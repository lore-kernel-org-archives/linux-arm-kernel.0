Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9288C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:40:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10C320839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VGg2rgvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10C320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TUev/htoGTDWuVQxjKKSGfAngje6AVGrXXiVY4LvFww=; b=VGg2rgvGC7O0oR
	amrnT+dXSSNWmrJm9k8eLU/RQQNiIkkhXEVwgLslD4/IM+fpxoZgFIgx9qQ71j68cr2E1XzZSVAUa
	rVLyfnEpZtgVg9E2zvwvhFuvgTB/4v6hO8hjOAZ7CMlVUJvyXNmY/0dsrqgVXkea6rli9RyYKFA4X
	VWlfYTT2NHXsxZ7kOoGuJub9b7BvguwkLnWVRqbf/AR3+SW7HXL2NVfRcTYh23VcE0cBNj8ihxwFG
	KUIFyyow6GSgC0EUIKuqXvLSHuv4NGj6UpjvhNeVPJTuNvKmmhM6a8Or66pcojLWex08zhX0MJdBG
	R4S5P75jeCk+3dVTgrQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX5gf-0007O5-2m; Wed, 12 Dec 2018 14:40:33 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX5gX-0007NE-RZ
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 14:40:31 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 01E4B809F;
 Wed, 12 Dec 2018 14:40:17 +0000 (UTC)
Date: Wed, 12 Dec 2018 06:40:11 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] ARM: omap2: remove unnecessary boot_lock
Message-ID: <20181212144011.GA6707@atomide.com>
References: <E1gX2qS-0003qy-FU@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gX2qS-0003qy-FU@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_064025_928459_B3D933F9 
X-CRM114-Status: UNSURE (   7.24  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Russell King <rmk+kernel@armlinux.org.uk> [181212 11:38]:
> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.

Looks good to me, you probably want to queue this along with the
other similar SoC patches:

Acked-by: Tony Lindgren <tony@atomide.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
