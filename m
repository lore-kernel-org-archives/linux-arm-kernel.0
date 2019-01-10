Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URI_HEX,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1764206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VL2a/VCZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="EPwZVIgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1764206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dXGvQWUkPj+xyBFb9aMne5btwsSUwzJcMhSADhybZ6s=; b=VL2a/VCZ/BEAEY
	6S2bxh0BGZ16odrAllE5o54e4eLlFLPGakbBy4b/6t5LxfffPXq9n4a16Qbl13QpRlkY50IJnuUE5
	iNg4Tev8Rn+7tH2VX1/bSQcYGfiNvGInknLTZesycDFXvmEA8CxTlh9Jj/uRfGnjikElZ7uVPnw3W
	2q3GBQSh/wc3BhJnQUSw5RvYKwhgCNw719GxL3pzSp6ME94RKYfmKuXZVEOtcpwOGmi3qLIIXPbgy
	6r3jUHMuMe4+vRQMx914cyyxh00RAdFoiMHWYpjC58eYU/IKoJMnLCSoB3W1yETHOAUCqwl/5qJCA
	c4Et0y/vksczk+PpW9OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXA9-0001x0-S2; Thu, 10 Jan 2019 10:02:09 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXA6-0001wY-CJ
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:02:08 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BCF5425B78D;
 Thu, 10 Jan 2019 21:02:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547114525; bh=Evv6/kUZM2BXEO4ID4kHm9U6pi6UaWggfSKsaCs7c7M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EPwZVIgLNQ3mAUE3y4DWNM7bFN+1AUHGqF5+XB7zc8f85SWpA5gMjdAAV/c66Jf2x
 vItbhyAtUueachhAMG4KI2NnFLCoKkZS4qHdqnPRtW+m4rYvi9S7FU1D614OFOO4bU
 fI12whi5V/eEX5xrd2KdWy9stsF3fzybJgPjApDU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id F0FCB940462; Thu, 10 Jan 2019 11:02:02 +0100 (CET)
Date: Thu, 10 Jan 2019 11:02:02 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Fix backlight
 regulator numbering
Message-ID: <20190110100202.4eqyge7vadlmodsy@verge.net.au>
References: <20190109140045.17449-1-marek.vasut@gmail.com>
 <CAMuHMdX3bP_WCYNRRMmVRPwV52e72NOZMtW8cf29Fo+E9_CvcQ@mail.gmail.com>
 <20190109165822.tmj7qbho46f7clvg@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109165822.tmj7qbho46f7clvg@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_020206_573946_30096A4E 
X-CRM114-Status: GOOD (  19.81  )
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
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 05:58:23PM +0100, Simon Horman wrote:
> On Wed, Jan 09, 2019 at 04:26:25PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 9, 2019 at 3:01 PM <marek.vasut@gmail.com> wrote:
> > > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >
> > > There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
> > > the eMMC and one 12V for the backlight. This causes one to be overwritten
> > > by the other, ultimatelly resulting in inoperable eMMC, which depends on
> > > the former. Fix this by renumbering the backlight regulator to regulator2.
> > >
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > Cc: Simon Horman <horms+renesas@verge.net.au>
> > > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Reported-by: Simon Horman <horms+renesas@verge.net.au>
> > > Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add backlight")
> > 
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > > --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > > @@ -191,7 +191,7 @@
> > >                 clock-frequency = <24576000>;
> > >         };
> > >
> > > -       reg_12p0v: regulator1 {
> > > +       reg_12p0v: regulator2 {
> > >                 compatible = "regulator-fixed";
> > >                 regulator-name = "D12.0V";
> > >                 regulator-min-microvolt = <12000000>;
> > 
> > Perhaps the node name should get a more descriptive suffix
> > (e.g. "regulator-12p0v"), like is already done for some of the other
> > regulators?
> 
> I think I would prefer that addressed in a follow-up patch.

Thanks for this patch.

I have now tested it and it looks good to me.
I can now access eMMC as a block device.

Tested-by: Simon Horman <horms+renesas@verge.net.au>

I plan to apply this for v5.1 as the problem appears to
be introduced in a patch queued-up for v5.1.



# dmesg | egrep "(ee160000.sd|mmc0|mmcblk0|backlight)"
[    0.893760] pwm-backlight backlight: Linked as a consumer to regulator.3
[    2.901953] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    2.910262] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    2.967591] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
[    3.049943] mmc0: new HS200 MMC card at address 0001
[    3.055843] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
[    3.064414] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    3.074888] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    3.081522] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)

# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.7343 s, 36.4 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 8.46809 s, 63.4 MB/s
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.6945 s, 36.5 MB/s

# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 19.1677 s, 28.0 MB/s
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 21.3139 s, 25.2 MB/s
# dd of=/dev/mmcblk0 if=/dev/zero bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 19.9205 s, 27.0 MB/s

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
