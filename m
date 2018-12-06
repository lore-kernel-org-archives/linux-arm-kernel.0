Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:51:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6564520878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ReH4Bk3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6564520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Lhq+gNeArJBMFGUekawBCqre8f5Xd94qGcVD7Q+4Y8=; b=ReH4Bk3a9hCBdN
	r1FEX8MmC6bnsbY1Yc1oaRmyK4rmxr8h4qiU2qmLXCxtNvlhnZpyZrR5B89xilJS8U64Z9YEDHZwv
	ILBuTeu/f3VzvpAOoIgV1e2SousfFgRUdPFnqYsOA++apEgnnEboEhq8D7ioWiNNWf6THfeMG5X+R
	kIwEEPFI3V8K8srCJchY3u4leNj5x7mCPVN8rRdaITF8G71N/a5Kv4RB1jjpCXoLodZkTQSFBzu7y
	s+TO5y8GATRHtpusMKkw1sEAhQV1ZkXRDOWoLNMh/Liz6jMp47tU7cHi2Jf8SJVcowGM4cMdhArrx
	sYmStYbO7bxAAUy3YZWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsBz-0006ij-8P; Thu, 06 Dec 2018 11:51:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsBw-0006hh-G3
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:51:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C160EBD;
 Thu,  6 Dec 2018 03:51:37 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5993E3F5AF; Thu,  6 Dec 2018 03:51:36 -0800 (PST)
Date: Thu, 6 Dec 2018 11:51:33 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH V4 6/6] arm64: mm: Allow forcing all userspace addresses
 to 52-bit
Message-ID: <20181206115132.GD54495@arrakis.emea.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-7-steve.capper@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205164145.24568-7-steve.capper@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_035140_534665_269BBBA4 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: linux-mm@kvack.org, ard.biesheuvel@linaro.org, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org, jcm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 04:41:45PM +0000, Steve Capper wrote:
> On arm64 52-bit VAs are provided to userspace when a hint is supplied to
> mmap. This helps maintain compatibility with software that expects at
> most 48-bit VAs to be returned.
> 
> In order to help identify software that has 48-bit VA assumptions, this
> patch allows one to compile a kernel where 52-bit VAs are returned by
> default on HW that supports it.
> 
> This feature is intended to be for development systems only.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
