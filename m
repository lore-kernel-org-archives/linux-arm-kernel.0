Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE351C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D07B2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cccn0J9N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="i08XiIGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D07B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Jn/fBt3jlssz1eSGnx5IgG7AVGAfE01vqVVS7Ungps=; b=Cccn0J9NmpOHGv
	VzH+mWfaZgMkFuFMbO5lgAzirRRVe8+gBwO1TkTDmVYjVFxDbHHtBxdZ65JsBROlWK21BPv65KMSY
	VVft+1xaVjd3MzzVZqen6X4v1kItmKXmv/PKRongCIQUCi69y8iQeBeESAA7zXI9idT98ybwsaXqY
	mRX/2vWv2BT557w70cJXtRV2tKVZ8nhICQB7Qg+1ZxIdvGZ4kUA0ENNb2/lvWW7d+QClucpwzSjdx
	V6f9LP3nzwEpiqe7gMP2lG2ZNGF2y1Gmk2KijFfwipRSbW75McUf09/D4rKOWJBUzBBgedeeNHBSk
	IUIwY7gKUYfM9vSS/4fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBzn-0001UF-2f; Tue, 04 Dec 2018 14:48:19 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBzj-0001PK-PJ
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:48:17 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 7C18440376;
 Tue,  4 Dec 2018 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1543934880; bh=RpekusIPREOQy76BBsQXOfXLmOTfl+GglVhMI6ztRs0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i08XiIGRl8Hx3Or1sD2xhVH+XpdZ7pe+XAdSi0ANDDbs1+O7VykF+fAuv9xV6pndc
 kckgPEJkNMxO+UjZrRv2OUKbBPalnFS1zNa61onePRE5acbbMXHyp9BKFCCyprB+Ea
 STPPeW6F6avuJ5A0wAUQ73blbVovnjdxfBdPc9PHVNKu7OdABQ5n9ISXZaK4b33Jt3
 YRhV3z39u1CSyfgckjMxappGa7deqFUIXCsRr/1Ts/0hcbDnOJyvw5kVcPt4DJHvu6
 bqKDXJoaZdkWu670ilONz30MZNgo7uDRFCby2ozMXdKca5LCdQs4njxKK5GGuKUp/d
 0Zhp1eFTeOlYA==
Date: Tue, 4 Dec 2018 14:47:59 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
Message-ID: <20181204144759.thsvooby6txag2yr@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
 <20181127093852.2iavgo4xipjnu25l@flea>
 <20181128095639.t4ogsk6ovyu2yaxu@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128095639.t4ogsk6ovyu2yaxu@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_064816_181811_44E94BEE 
X-CRM114-Status: GOOD (  14.43  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 10:56:39AM +0100, Maxime Ripard wrote:
> On Tue, Nov 27, 2018 at 10:38:52AM +0100, Maxime Ripard wrote:
> > On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:
> > > From: Olliver Schinagl <oliver@schinagl.nl>
> > > 
> > > With commit b43776d65a33b46092 ("ARM: dts: sunxi: Use axp209.dtsi for
> > > Olinuxino Lime2") we force them an arbitrary 2.8 volts. Granted, for
> > > LDO3 this may be less arbitrary, but for LDO4 this is just wrong.
> > > 
[ ... ]
> > As we discussed on the U-Boot ML already, this shouldn't be made
> > always-on but tied to the consumer device (the pinctrl one) instead.
> 
> Can you test that patch (not tested):
> http://code.bulix.org/h02vha-514284?raw

Quick test (after applying this: http://code.bulix.org/w01xab-518044?raw )
results in failure:

[snip]
dmesg -t |egrep "(regu|seria)"
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pb not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: Linked as a consumer to regulator.0
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pb not found, using dummy regulator
1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 47, base_baud = 1500000) is a U6_16550A
sun4i-pinctrl 1c20800.pinctrl: Couldn't get bank PG regulator
sun4i-pinctrl 1c20800.pinctrl: pin-198 (1c28c00.serial) status -22
dw-apb-uart 1c28c00.serial: Error applying setting, reverse things back
dw-apb-uart: probe of 1c28c00.serial failed with error -22
sun4i-pinctrl 1c20800.pinctrl: Couldn't get bank PG regulator
sun4i-pinctrl 1c20800.pinctrl: pin-202 (1c29000.serial) status -22
dw-apb-uart 1c29000.serial: Error applying setting, reverse things back
dw-apb-uart: probe of 1c29000.serial failed with error -22
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
sun4i-pinctrl 1c20800.pinctrl: 1c20800.pinctrl supply vcc-pa not found, using dummy regulator
...
[/snip]

And I cannot actually see the link between pinctrl and ldo4. There's currently only this link:

sun4i-pinctrl 1c20800.pinctrl: Linked as a consumer to regulator.0

$ cat /sys/class/regulator/regulator.0/name
regulator-dummy


> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
