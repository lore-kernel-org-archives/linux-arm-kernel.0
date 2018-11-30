Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E18C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:18:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291C72082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMD7Itjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291C72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WJRgb9rZTSjiU6f95j9M/Qbh8gWvvjoPq3ckfv4SXK8=; b=HMD7ItjxRtPYlv
	UH62F4wfI+0UIpeM6WddZbDjKWL4LTOBGhv3GRlKl3nZ1jpDObavZfmfwOeEFRbagmTyNvhHWZ8cM
	CoMt2bTUk0OOoEa3mYBhuMe+TMpZUrr2m0CXyL73c+GHl0bxaXr6omAJCqgGTWhk8/dyxlCKhtGwF
	AVHVpNdR49Ya2OXmvTKbxbHra3lMMuXqL04ZBU9gIhDQtW8ogBzo2S6pQ6o0E5nkguISeq9LFireE
	ILFqKeZaUYh9YDrmKwxYpPoY+0cSRy0coAVi4rVtGhHMB/JuHbC0pE5ZGhIt+/gkihIZQMkReexal
	8lxGLac5AQOoU3eICG+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSoJ4-0007Sj-6N; Fri, 30 Nov 2018 19:18:30 +0000
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSoJ0-000773-Cx
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:18:28 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d67 with ME
 id 6KJ91z0030nnJME03KJ9Ps; Fri, 30 Nov 2018 20:18:12 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 30 Nov 2018 20:18:12 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
 <25087bc1-950d-b75a-1594-9f0d969dd59d@kernel.org>
X-URL: http://belgarath.falguerolles.org/
Date: Fri, 30 Nov 2018 20:18:08 +0100
In-Reply-To: <25087bc1-950d-b75a-1594-9f0d969dd59d@kernel.org> (Sinan Kaya's
 message of "Fri, 30 Nov 2018 10:59:34 -0500")
Message-ID: <87pnumxtlb.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_111826_749978_E148799D 
X-CRM114-Status: GOOD (  14.51  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: dmaengine@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
 linux-arm-msm@vger.kernel.org, sudeep.dutt@intel.com, haojian.zhuang@gmail.com,
 linux-kernel@vger.kernel.org, ashutosh.dixit@intel.com, david.brown@linaro.org,
 vkoul@kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org,
 dan.j.williams@intel.com, linux-soc@vger.kernel.org, daniel@zonque.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sinan Kaya <okaya@kernel.org> writes:

> On 11/30/2018 10:42 AM, Yangtao Li wrote:
>> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define
>> such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify some
>> code.
>>
>> Signed-off-by: Yangtao Li<tiny.windzz@gmail.com>
>> ---
>>   drivers/dma/amba-pl08x.c     | 14 ++------------
>>   drivers/dma/mic_x100_dma.c   | 22 +++-------------------
>>   drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
>>   drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------

For pxa_dma:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
