Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C724CC2F42E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:07:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9826020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n0nNfEXu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="Vy1o9QfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9826020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rf+Rgoe4X1uuNBRir9D58RjXzj+UB1mNTdjAmhQQpBo=; b=n0nNfEXuqEzbDy
	hMdXMSsyOBwyOuC5qJz7Fvh7qQFheOgg3wHsddLzlcGzyWiZU0eO/HK51Vk0d0MzeiiAyXq5UleGK
	aYZcUhkJ3cHL3a5GMDvdo85I1zSKpzMyy6VyZgb8kl7dz/ieDaunaRKsfbLNkxO4pEi5xrzZRARWw
	+X9cNi8UkLui77W64m+YHc0xShlNNxXOSrrmfKj3W/xa6Y9HQBKo31H1X/ofEtzjY8d8X5RZcGKl7
	wCcAhK+f/XYBxDlMOkgePbrcn22Nr8jms6q+f1HkFHvVU8mefnTEufTb/5258SXiv7qfOH2L2vQvH
	//g8VPskH8i9DyJJk6Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbAm-000168-Li; Mon, 21 Jan 2019 15:07:36 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbAi-00015d-BC
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:07:34 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id D115140220;
 Mon, 21 Jan 2019 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1548083249; bh=TpgTPM7pm8AQpKfM36uZ5ZljAUkQIJ19cyrkYU94XdM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vy1o9QfAFF4jY1xE14v8INm+KI24Z/o9Oedx749eTieY2F34Ah9MSoWCDgU+Wmbu2
 rAKzFor4t2lmaNX9OVPdXeKxUjE6P/1r0TakvTIzNiQYQsrXANAaDGzbZd/+erK9NV
 SlFztr0foSlsSagvXMH8eiznZ3MM2AfSYLZ2+R3ENzfamib5Vfn/3lmTNCU9Q4xCYP
 npznZw2Ct9MqHVSgbHUzEJweaF7mjCXPHF4qlWbW/E6f1HQpszCMZjkDCjEPd0pK50
 HFcUSbSSlvPFYBApQgsp8okILSj8zqfVIaogIoK7mOsB+tVx4dCfHk2CG7r7SCB6jH
 bNaT9RQH9ACqQ==
Date: Mon, 21 Jan 2019 15:07:28 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190121150728.tw4ryjgzzbxh7qmc@plaes.org>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
 <20190116075854.o2kme5nxq5kckwem@plaes.org>
 <20190116192442.qz4xi2ky6axgiyvg@flea>
 <20190116203516.s7pisy4miaclo63u@plaes.org>
 <20190117113340.ydszal5c3nlrqr47@flea>
 <20190118101053.gkxpfymsjzw3ptxf@plaes.org>
 <20190118140418.m5mliyvddfdfju3v@flea>
 <20190118145126.mpjz5t5hjqqpgzys@plaes.org>
 <20190121132517.iv2v3hug4uihefnk@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121132517.iv2v3hug4uihefnk@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_070732_666304_B1850C8C 
X-CRM114-Status: GOOD (  28.54  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, Jonathan Liu <net147@gmail.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 02:25:17PM +0100, Maxime Ripard wrote:
> On Fri, Jan 18, 2019 at 02:51:26PM +0000, Priit Laes wrote:
> > On Fri, Jan 18, 2019 at 03:04:18PM +0100, Maxime Ripard wrote:
> > > On Fri, Jan 18, 2019 at 10:10:53AM +0000, Priit Laes wrote:
> > > > > > > > > It doesn't look related to the clock rate itself, since it doesn't
> > > > > > > > > change between the two cases. However, in one case the DDC clock is
> > > > > > > > > enabled and in the other it's disabled.
> > > > > > > > > 
> > > > > > > > > Was it taken at the same time? Maybe you can try with that patch?
> > > > > > > > > http://code.bulix.org/z7jmkm-555344?raw
> > > > > > > > 
> > > > > > > > Thanks, after doing ~50+ boots I haven't seen a single failure.
> > > > > > > > 
> > > > > > > > Previously I had following failure cases which are now both fixed:
> > > > > > > > 
> > > > > > > > a) Linux without u-boot HDMI, where one in every 6-7 boots failed.
> > > > > > > > b) u--boot with hdmi enabled switching to simplefb and then switching
> > > > > > > > to kms, where previously all boots ended up with garbled screen.
> > > > > > > 
> > > > > > > So it's not really a fix, but it really looks like the clock is not
> > > > > > > enabled when it should.
> > > > > > > 
> > > > > > > Can you describe your test scenario a bit more? What are you doing
> > > > > > > exactly, just booting? When do you start using the display? When did
> > > > > > > you capture the debugfs output that you pasted?
> > > > > > 
> > > > > > Display is already connected via HDMI to the board. I don't really
> > > > > > remove it, I just boot the device and let it start Xorg.
> > > > > > Meanwhile I just ssh into the device and capture debugfs output.
> > > > > > See my 3 testing scenarios below.
> > > > > > 
> > > > > > Kernel also includes one extra patch to fall back to DDC, in case HPD
> > > > > > fails. Mostly the same I already submitted last November [1].
> > > > > 
> > > > > Do you have the same issue without that patch?
> > > > 
> > > > Can't really test this display without this patch and I do not have other
> > > > HDMI/DVI screens. And this issue does not happen with other HDMI displays
> > > > that I have here.
> > > 
> > > Can't you just force the monitor to be reported as present? It's not
> > > great and we don't want to merge it, but that would allow you to test
> > > that setup without too many interferences.
> > 
> > Baseline is clean u-boot / linux. U-boot does not detect/enable display.
> > 
> > 1) Booting Linux with drm.debug=0xe
> > 
> > * Linux does not detect/enable display
> > 
> > 2) Booting with drm.debug=0xe video=HDMI-A-1:640x480@60e
> > 
> > * Linux detects display, but display is garbled, and proper edid data is detected:
> > 
> > [snip]
> > pll-video1                     0        0        0   327000000          0     0  50000
> >    pll-video1-2x               0        0        0   654000000          0     0  50000
> >       hdmi-tmds                0        0        0    25153846          0     0  50000
> >          hdmi-ddc              0        0        0       89835          0     0  50000
> > [/snip]
> > 
> > 3) Booting with drm.debug=0xe video=HDMI-A-1:640x480@60e
> > And also one extra patch for Linux where HDMI DDC clock marked as critical
> > 
> > Linux detects and initializes display properly:
> > [snip]
> > pll-video1                     1        1        0   327000000          0     0  50000
> >    pll-video1-2x               1        1        0   654000000          0     0  50000
> >       hdmi-tmds                1        1        0    25153846          0     0  50000
> >          hdmi-ddc              1        1        0       89835          0     0  50000
> > [/snip]
> 
> I guess you'll need to track down when the hdmi-tmds and hdmi-ddc are
> enabled and disabled, and if it makes sense :/

OK, figured out the cause.

Apparently, for each ddc poll we enable ddc clock which is a child of TMDS
clock. After transfer is done, we disable the clock and this also tears down
the parent because its only user has gone missing.. :(


So basically, patch below also works, but I guess we should override
the sun4i_tmds_ops.disable to properly account for tmds clock use.

---
@@ -225,7 +235,7 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
        init.ops = &sun4i_tmds_ops;
        init.parent_names = parents;
        init.num_parents = 2;
-       init.flags = CLK_SET_RATE_PARENT;
+       init.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL;
 
        tmds->hdmi = hdmi;
        tmds->hw.init = &init;


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
