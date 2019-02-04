Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30253C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:51:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A802082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHHDaXKL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCSvXKHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A802082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iWi8c3+aSl6KW4152TZjbBk6knuiVJ4KFrq6cCAk+5Q=; b=LHHDaXKLLrsC5M
	cgQqoBCbBlNGckIKWTeN9cK3vIsF17rx4hEtugVUe0f+ftCN7XaaHGL2FYZ9irl+w1y2rrzqXaORA
	UClXu2tRHQ/kigpdbEAnFPDy27/oxAKRWnG1cIYr9+GGfTPtlkk++qo/repG6WmdlIL2XNRUGFZSx
	HVeAh/jHTVJLCgw2RojLK6xWPqnLjj+bcSe5fL7yxO31s5CdBRVxTEEA7PmL1TyNmorkf3Zd78R5n
	CW4UIetHYg5j4VNvFhbANnLT6imPX7hOA9P8NttQ766o0DufdQ/OxFkfkydOu4vjLdCPEmBYp0uLK
	aP83iZjnr077sbXdE6Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqjKb-0000Dd-JO; Mon, 04 Feb 2019 18:50:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjKZ-0004UC-Mj
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 18:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rjDm323sA1rHjFNzXvp8mog88pX71pbusVrp8s829yE=; b=CCSvXKHRkKQu1hLD0WB0Tk1iKJ
 6awWzvGoUtuX31v6gclVBjIcwgiqn1Vw6WI+nBW4+0KHwpnl5jJL2QzxAYa+JpsHx0El7pzo6vgNb
 vyuv8AZ7NqwnpQL4zIj6PBXP/JNyCJk/sFD1fhElDMDdAyMuPggNoLZxsBBM5IgzPk/HWpWVRoMrj
 E0QCKm2cFIVp1quzxr3jmKs/5T7MPvOz8Ee3PHSIF852sqlzvKLwm8wnUW36Jc1dF6E5Ji8Jwcq/S
 AklOnN/4A94Wuax/yGEKsgcRZLDf/vYYv7Plu7WJ+I0JVbCuts3eOctufQNiLdv8LOLP2x0HO16rY
 +GJPBz8w==;
Received: from muru.com ([72.249.23.125])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqjDc-0001nu-VU
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 18:43:46 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 44333808C;
 Mon,  4 Feb 2019 18:43:29 +0000 (UTC)
Date: Mon, 4 Feb 2019 10:43:17 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190204184317.GO5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
 <20190204155604.GH5720@atomide.com>
 <20190204193311.102a60e6@kemnade.info>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204193311.102a60e6@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_184345_136734_11F3DFB6 
X-CRM114-Status: GOOD (  20.61  )
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
Cc: linux-omap@vger.kernel.org, khilman@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 letux-kernel@openphoenux.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Andreas Kemnade <andreas@kemnade.info> [190204 18:33]:
> On Mon, 4 Feb 2019 07:56:04 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> > > Enabling off mode was only reachable deeply hidden
> > > in the debugfs. As powersaving is an important feature,
> > > move the option out of its shady place.  
> > 
> > How about let's enable always if we have the twl4030
> > configured to allow it? You can just check if the dts has
> > "ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
> > properties set.
> > 
> > In order to enable deeper idle states, the user space still
> > needs to idle the UARTs and possibly other hardware blocking
> > idle. So we should be safe there.
> > 
> Let us not mix up runtime pm and system pm. The uarts need
> to be idled for runtime suspend, but they are off/ret for
> system suspend without userspace intervention, so allowing off mode
> will have an influence even without uart runtime suspend,
> and also probably for other powerdomains (non-core/per).
> So we still need to be sure to handle at least some erratas and
> context save/restore correctly.

True that's a good point.

> Your Idea seems to be in pseudocode
> if (powersaving_wanted)
> 	enable_off_mode()
> 
> I had something in mind like
> if (system_is_trusted_to_handle_offmode()
> 	enable_off_mode()

For omap3, the properties for "ti,twl4030-power-idle" or
"ti,twl4030-power-idle-osc-off" mean just that.

The PMIC is wired and configured for off mode, and those
properties should not be set unless the system is truly capable
of entering off mode. If not set, we should not enable off
idle by default.

Otherwise the boards should be already using just
"ti,twl4030-power" or "ti,twl4030-power-reset".

So it should be safe to set a flag for off_mode based
on that flag during boot, or set a flag for off
mode allowed if the flag is needed later on.

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
