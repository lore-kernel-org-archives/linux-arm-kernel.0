Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07522C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60382148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WaXaC2rA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ePY/RoYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60382148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=koScMDAiWyqAAC+rGqjTDG9snpv6Fo3g9IuxX4Yis7Y=; b=WaXaC2rAoEO7jy
	CnWnQ16wKnyHh5Fvtk5kfXe8Nd0RhSoyJI/oUx910UTgK5HYcSBymadk9vbWK6uXIlrNzVRtymiXM
	IojShVa7MZELBdbgZRgzaYAQWqJt62uWrr5lNCiafb37+trrU31C1/9HmbdD3JUl0J/dcoJMCE5Dn
	8bihgjVzFbOVVUbBia+4rJUWlr7+ZqCBp7Cji3NSAieAJkw5MJnLyqPotXPFOsw11+R4cHYWdzklx
	qNMap3TxUUnNng5pPVxQO+tjTrKbPWXE6VShrUGoiDDDWJPmMe2pgQMT7adX96SlfIxwN9G6qD0nJ
	AlfC0g8W4hR9+oNKSvhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcUhU-0007Of-BB; Thu, 27 Dec 2018 12:23:44 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcUhQ-0007NS-5G
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 12:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HHqgO3g5eKkRPwsjUKEmcI0sspvwSEMM8uaX2s6O3rw=; b=ePY/RoYXWZLWq3Glc0Vxv4Ye5
 Ir06qg4PuLm6ffDQRXlPPLFYGtq2gf+yfEu2oqyvIG3cRKpWBkYMeErVUTGzWPql4mml0LKKb0R3R
 iNaqiE+ItFgEcYbuDpNPT2nilitVkCQ3q0KQF7a6xyDUjr9qztxD9OYU+H5fE9UYYUw/w=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:36879)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gcUgm-0000z1-Jp; Thu, 27 Dec 2018 12:23:00 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gcUgj-0001g4-D5; Thu, 27 Dec 2018 12:22:57 +0000
Date: Thu, 27 Dec 2018 12:22:55 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Message-ID: <20181227122254.GB26090@n2100.armlinux.org.uk>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
 <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
 <cff15a85-3f72-a8ea-2e5f-731963175fde@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cff15a85-3f72-a8ea-2e5f-731963175fde@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_042340_197700_20DEB947 
X-CRM114-Status: GOOD (  16.05  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 BOUGH CHEN <haibo.chen@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 27, 2018 at 10:01:24AM +0200, Adrian Hunter wrote:
> On 20/12/18 9:49 AM, BOUGH CHEN wrote:
> > i.MX6ULL has errata ERR010450, point out that due to SOC I/O
> > timing limitation, for eMMC HS200 and SD/SDIO 3.0 SDR104, the
> > clock rate can't exceed 150MHz. And for eMMC DDR52 and SD/SDIO
> > DDR50 mode, the clock rate can't exceed 45MHz.
> > 
> > This patch add this limit for imx6ull.
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> 
> Apart from the kbuild test robot complaints (do they need to be fixed?):
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Nacked-by: Russell King <rmk+kernel@armlinux.org.uk>

The kbuild test robot complaints do need to be fixed first.  They're
confusing because GCC produces quite a lot of garbage in its error
messages now.  If you look at the patch, there's a hunk that has:

+       if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+               if (imx_data->is_ddr)
+                       clock = clock > 45000000 ? 45000000 : clock;
+               else
+                       clock = clock > 150000000 ? 150000000 : clock;
+

which is missing a closing brace.  This patch could not have been
build tested before it was mailed to the list, and the test robot
is highlighting that fact.

It may also be a good idea to encourage a different approach to the
above anyway:

	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
		unsigned long max_clock;

		max_clock = imx_data->is_ddr ? 45000000 : 150000000;

		clock = max(clock, max_clock);
	}

rather than open-coding the max() stuff in the driver.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
