Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9234C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:52:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A932147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jZxmf/gF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+hYjJZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A932147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b9y2Gu0KyxppE8LrghvZDEj9CPi8RvjDld0HFM1KNMs=; b=jZxmf/gFhnAPPc
	mOuUa5qnRj/hBvLZXit5nV19Obs6S+bDVxVOBfZSqhZZzwagWcccsKXXZwfKoHOtjXEeRefVDHKSN
	GTlMLkVQI1ekN7GiPMwBWQK0hdnnkEmh2K4pJXTU35AMpA4wU903ABPkeAEvAYeKz71Zk5Oy/tNok
	f3W6jv9QvUhDx/n/epjP47ATZ88mK23W/FxTn2lgC+pUDy7gS6PknXUcLaytdCOwPHBmTOd/Ji7ZF
	gQm60+z/WbzArozC79+PWZ+Hu55rUbO2XRJ1L9i9G2SBhM2LQT5F2UkFTzbKbUqdSHL1ck2H7FdSQ
	Ezl0KzuPhay1JOvlytGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpiw-0007yv-6a; Thu, 07 Feb 2019 19:52:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpis-0007yZ-QY; Thu, 07 Feb 2019 19:52:36 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E9A32147C;
 Thu,  7 Feb 2019 19:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549569154;
 bh=yNiMpTVg55DaX5Wf82kFMN/MvA5KnKfjzih2bD2G7iI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e+hYjJZdsYNknAZCPGXeN2oMMyEhTpy+RSXu9dl/HyycUAcl8E7nH471ma+Mmeymp
 GG9RLlISCngYJDib5cVcO824lVsGIaNNBSIr0N3AOYzxbkXHR5YLdzkFeHyoHSi6mw
 3UdqSqt4aB8x6fqygxfHjFJ0g5T6nEfy9CoaxMxs=
Date: Thu, 7 Feb 2019 13:52:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [RFC PATCH] PCI/portdrv: Support for subtractive decode bridge
Message-ID: <20190207195230.GJ7268@google.com>
References: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
 <20190207151816.GI7268@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207151816.GI7268@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_115234_872227_FBB96334 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com, poza@codeaurora.org,
 fred@fredlawl.com, linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 09:18:16AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 14, 2018 at 11:40:29AM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> > change the class_mask values to make portdrv support this type bridge.
> 
> I assume you have a Root Port or Switch Port that supports subtractive
> decode?  I'm trying to understand how such a device would work.
> 
> Out of curiosity, can you show the "lspci -vv" output for the device
> and the downstream devices of interest?

Actually, since subtractive decode has to do with how the bridge
interacts with its *peers*, what would be interesting is the host
bridge window information from ACPI _CRS or DT and the lspci info for
everything under that host bridge.

Assuming we're talking about a Root Port, I guess that would mean
anything inside the host bridge windows but outside the positive
decode windows (the normal PCI-PCI bridge apertures in the Root Ports)
would be claimed by the subtractive decode Root Port?

I guess you would want this because this path ultimately leads to an
ISA or similar bus where you don't know what resources the device
actually consumes?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
