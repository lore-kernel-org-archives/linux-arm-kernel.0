Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5A6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:00:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE282146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p9+jCawv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="htDJUmv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE282146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U6a2lLxbs3gy68s5kNtjoGkA57X8Y38KG8F/R9nEHyU=; b=p9+jCawv387w9jklfhrPrCfRM
	N5whzbmPQRkBZbXferVaOD5e6Ds7aYbCqH3GSDE422dWO+l7cvBWqe+F24n2dknXTDn1o0UeF5xro
	dwg3KMeBwmvCd304jiEBeVfQ5KC/ers0y16JtdIuUWNvMFuPH4sL1bf4h0MLM9Aw1Fyv/UN9OdbIa
	0JLJZd1Ivqns17YOmT4Eeef2OaFN61oYtqhpzYiqjBggoHAMbwH5uSOtLjZeFWFwpG5k4naGICdOu
	hWG8jTLMRwuRe3A7l3gvW0ljL9PBrjLBGt4AyEeUmQCsniGBgTXuXgSju0WR7AAuqCn3OZiw6q9pJ
	Mbv4rroIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSlDN-0003Q6-Mq; Fri, 30 Nov 2018 16:00:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSlDA-00025A-3R
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 16:00:13 +0000
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com
 [174.109.247.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7383320867;
 Fri, 30 Nov 2018 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543593601;
 bh=4qlII825xNUpRHgMnW1yIPhJogC4Kpu0TeOslesnxCs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=htDJUmv6XXoILmYZ9zAKdJII0H9gkoYel97tzjryuPgJ3hnybvF7Bl8LqTHciJQlR
 1RrTe6UtQR23sLjuhxkkNXbwidL/zEC98fxNZ1o2pP2nzk91kvqwB4TvbS+60ZGWud
 03/45UKeE5HL8qkrhsahkCQC+XLSrlgGYiOz4iGg=
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
To: Yangtao Li <tiny.windzz@gmail.com>, dan.j.williams@intel.com,
 vkoul@kernel.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 andy.gross@linaro.org, david.brown@linaro.org
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <25087bc1-950d-b75a-1594-9f0d969dd59d@kernel.org>
Date: Fri, 30 Nov 2018 10:59:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181130154249.3222-1-tiny.windzz@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_080012_162938_56938A6B 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/30/2018 10:42 AM, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define
> such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify some
> code.
> 
> Signed-off-by: Yangtao Li<tiny.windzz@gmail.com>
> ---
>   drivers/dma/amba-pl08x.c     | 14 ++------------
>   drivers/dma/mic_x100_dma.c   | 22 +++-------------------
>   drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
>   drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------

Acked-by: Sinan Kaya <okaya@kernel.org> for drivers/dma/qcom/hidma_dbg.c

>   4 files changed, 23 insertions(+), 70 deletions(-)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
