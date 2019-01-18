Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5248CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:11:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B06C2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+L2gxTt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="PzO4LdyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B06C2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w/2sF0sb1ux0EI36uI8mmvY03B+NMlfGgVfIj/D9DAA=; b=H+L2gxTt/d2ipzo+6H3OHxNGA
	AK4HlvhIURH2WrSSvRvLQgG+PXPceWYPKrQNLiCLxqrVU1vqTsaw+Z4hqjCwE+ShDpYjAIyixsgoO
	a8fH3bmziu/rakiA7izSS+g2x/8wAvdPJD1xnq1WY8BL1EozKHoppTyvClG045uYB1rC9mLQY0Ndy
	Ng0cVkZ5HP9KjqX2i99c4hC9y9bwNbFOEgSWciq65QiPlQNayAmjPq6AsCbS+2AzGR7J9baimucUq
	gZIsvwzCHZFwtyQ8JJvmTj2KZc1cp9Dq5NMqa8dAcoxXZ3gzYZZPq1Zi0VVPTO/pZ7ylfIfKyTG4y
	CgqPeTSzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkR7h-0000S1-Tw; Fri, 18 Jan 2019 10:11:37 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkR7X-0000R0-Hp
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:11:35 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 35F2B4022E;
 Fri, 18 Jan 2019 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1547806254; bh=qbkyKgPG6nd+zPmmKkj/cJai1W6NchpOU0k6XnOnWLo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PzO4LdyMpYxKW1sNfQN03BSzehVNZA+kfh95BVP4lm+oHFE6/NQ4BJ5MfghDfmjIn
 27YCJh8LUQJI8Cq5a04gG/rji54g/T/ChneJJ5WzvEhjP/DBysvj/ZMzkLm7adGTy4
 q5qOsaE04xvs0f0IXIweZOKS4Fps/SsaVwRchnwHwgHd2Xza5HsLfWicwRrmtVanFx
 +EQ6cYUC5UVGrw5aMABmIfg3RkRjS8QAE3uyuLuA+/oOlkUmLmWnkfroaayBvGWZJ1
 vvuiUW/zWuFB8u7H3lLxLiGPTfDdFF37t7pSYdgAEuRWNiyZccQNi+ItL3FscNQRAb
 2wFxqarbDgpqg==
Date: Fri, 18 Jan 2019 10:10:53 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190118101053.gkxpfymsjzw3ptxf@plaes.org>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
 <20190116075854.o2kme5nxq5kckwem@plaes.org>
 <20190116192442.qz4xi2ky6axgiyvg@flea>
 <20190116203516.s7pisy4miaclo63u@plaes.org>
 <20190117113340.ydszal5c3nlrqr47@flea>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fr3qwj52adqhjctl"
Content-Disposition: inline
In-Reply-To: <20190117113340.ydszal5c3nlrqr47@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_021129_367632_1EEF7A86 
X-CRM114-Status: GOOD (  37.16  )
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--fr3qwj52adqhjctl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 17, 2019 at 12:33:40PM +0100, Maxime Ripard wrote:
> On Wed, Jan 16, 2019 at 08:35:16PM +0000, Priit Laes wrote:
> > On Wed, Jan 16, 2019 at 08:24:42PM +0100, Maxime Ripard wrote:
> > > Hi Priit,
> > > 
> > > On Wed, Jan 16, 2019 at 07:58:54AM +0000, Priit Laes wrote:
> > > > > On Mon, Jan 14, 2019 at 01:29:34PM +0000, Priit Laes wrote:
> > > > > > I have a somewhat curious case with one HDMI/DVI screen that fails
> > > > > > to initialize properly every 6-7 boots. The display itself is also
> > > > > > somewhat flawed (missing HPD pin and the VSYNC/HSYNC pulse width
> > > > > > is set to 0 in EDID), but I suspect there could be some issues
> > > > > > regarding timing in A20 HDMI driver in Linux.
> > > > > > 
> > > > ...
> > > > 
> > > > > It doesn't look related to the clock rate itself, since it doesn't
> > > > > change between the two cases. However, in one case the DDC clock is
> > > > > enabled and in the other it's disabled.
> > > > > 
> > > > > Was it taken at the same time? Maybe you can try with that patch?
> > > > > http://code.bulix.org/z7jmkm-555344?raw
> > > > 
> > > > Thanks, after doing ~50+ boots I haven't seen a single failure.
> > > > 
> > > > Previously I had following failure cases which are now both fixed:
> > > > 
> > > > a) Linux without u-boot HDMI, where one in every 6-7 boots failed.
> > > > b) u--boot with hdmi enabled switching to simplefb and then switching
> > > > to kms, where previously all boots ended up with garbled screen.
> > > 
> > > So it's not really a fix, but it really looks like the clock is not
> > > enabled when it should.
> > > 
> > > Can you describe your test scenario a bit more? What are you doing
> > > exactly, just booting? When do you start using the display? When did
> > > you capture the debugfs output that you pasted?
> > 
> > Display is already connected via HDMI to the board. I don't really
> > remove it, I just boot the device and let it start Xorg.
> > Meanwhile I just ssh into the device and capture debugfs output.
> > See my 3 testing scenarios below.
> > 
> > Kernel also includes one extra patch to fall back to DDC, in case HPD
> > fails. Mostly the same I already submitted last November [1].
> 
> Do you have the same issue without that patch?

Can't really test this display without this patch and I do not have other
HDMI/DVI screens. And this issue does not happen with other HDMI displays
that I have here.

> > For u-boot I have also some extra patches, to detect HPD-less HDMI
> > displays [2] + relax some EDID timing checks [3] so u-boot can actually
> > initialize my screen.
> 
> Do you have the same issues without those patches?

Yes. Without those patches display is not detected by u-boot (issues with
missing hpd pin and stricter edid checks), so kernel initializes display.

Disabling those patches is mostly the same as disabling the HDMI support
in u-boot the kernel side.

> > So first configuration with 100% failures:
> > 1) u-boot initializes HDMI ( A20-OLinuXino-Lime2-eMMC_defconfig )
> > 2) Linux switches to simplefb
> > ... somewhere around here blinking cursor is replaced with garbage
> > on screen 
> > 3) Linux switches to kms
> > 4) Xorg starts
> > 
> > Second scenario with failure every 6-7 boots:
> > 1) Disabled HDMI in u-boot for my board
> > 2) Linux sets up kms (sometimes fails here)
> > 3) Xorg starts
> > 4) ssh to machine and take the clock dump
> 
> Do you have the DRM fbdev emulation enabled in that case or is Xorg
> the first to setup the kms driver? Do you have some logs and a
> configuration?

Xorg logs for scenario 1 and 2 are basically the same whether or not
HDMI is enabled in u-boot. Now, differences arise when DDC clock is
marked as critical. Attached files:
* Xorg.0.ddc-critical.log
* Xorg.0.ddc-default.log

Also attached drm.debug outputs.

> Maxime
> 
> -- 
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



--fr3qwj52adqhjctl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Xorg.0-ddc-critical.log"

Linux with (edid fallback + clk_critical patch)

----

[    12.552] 
X.Org X Server 1.19.2
Release Date: 2017-03-02
[    12.553] X Protocol Version 11, Revision 0
[    12.553] Build Operating System: Linux 4.9.0-8-armmp-lpae armv7l Debian
[    12.553] Current Operating System: Linux xxx-screen 5.0.0-rc1-00021-g9b31f15d4c57 #76 SMP Fri Jan 18 11:12:40 EET 2019 armv7l
[    12.553] Kernel command line: console=ttyS0,115200n8 root=/dev/mmcblk0p1 rootwait debug
[    12.553] Build Date: 03 November 2018  05:53:43AM
[    12.553] xorg-server 2:1.19.2-1+deb9u5 (https://www.debian.org/support) 
[    12.554] Current version of pixman: 0.34.0
[    12.554] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[    12.554] Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    12.554] (==) Log file: "/var/log/Xorg.0.log", Time: Fri Jan 18 09:13:19 2019
[    12.573] (==) Using system config directory "/usr/share/X11/xorg.conf.d"
[    12.576] (==) No Layout section.  Using the first Screen section.
[    12.576] (==) No screen section available. Using defaults.
[    12.577] (**) |-->Screen "Default Screen Section" (0)
[    12.577] (**) |   |-->Monitor "<default monitor>"
[    12.578] (==) No monitor specified for screen "Default Screen Section".
	Using a default monitor configuration.
[    12.578] (==) Automatically adding devices
[    12.578] (==) Automatically enabling devices
[    12.578] (==) Automatically adding GPU devices
[    12.578] (==) Max clients allowed: 256, resource mask: 0x1fffff
[    12.580] (WW) The directory "/usr/share/fonts/X11/misc" does not exist.
[    12.580] 	Entry deleted from font path.
[    12.580] (WW) The directory "/usr/share/fonts/X11/cyrillic" does not exist.
[    12.580] 	Entry deleted from font path.
[    12.580] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not exist.
[    12.580] 	Entry deleted from font path.
[    12.580] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not exist.
[    12.581] 	Entry deleted from font path.
[    12.581] (WW) The directory "/usr/share/fonts/X11/Type1" does not exist.
[    12.581] 	Entry deleted from font path.
[    12.581] (WW) The directory "/usr/share/fonts/X11/100dpi" does not exist.
[    12.581] 	Entry deleted from font path.
[    12.581] (WW) The directory "/usr/share/fonts/X11/75dpi" does not exist.
[    12.581] 	Entry deleted from font path.
[    12.581] (==) FontPath set to:
	built-ins
[    12.581] (==) ModulePath set to "/usr/lib/xorg/modules"
[    12.581] (II) The server relies on udev to provide the list of input devices.
	If no devices become available, reconfigure udev or disable AutoAddDevices.
[    12.581] (II) Loader magic: 0x5f0f60
[    12.581] (II) Module ABI versions:
[    12.581] 	X.Org ANSI C Emulation: 0.4
[    12.581] 	X.Org Video Driver: 23.0
[    12.581] 	X.Org XInput driver : 24.1
[    12.582] 	X.Org Server Extension : 10.0
[    12.588] (++) using VT number 7

[    12.588] (II) systemd-logind: logind integration requires -keeptty and -keeptty was not provided, disabling logind integration
[    12.592] (II) xfree86: Adding drm device (/dev/dri/card0)
[    12.603] (II) no primary bus or device found
[    12.604] 	falling back to /sys/devices/platform/display-engine/drm/card0
[    12.604] (II) LoadModule: "glx"
[    12.617] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    12.843] (II) Module glx: vendor="X.Org Foundation"
[    12.843] 	compiled for 1.19.2, module version = 1.0.0
[    12.843] 	ABI class: X.Org Server Extension, version 10.0
[    12.844] (==) Matched modesetting as autoconfigured driver 0
[    12.844] (==) Matched fbdev as autoconfigured driver 1
[    12.844] (==) Assigned the driver to the xf86ConfigLayout
[    12.844] (II) LoadModule: "modesetting"
[    12.847] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
[    12.854] (II) Module modesetting: vendor="X.Org Foundation"
[    12.854] 	compiled for 1.19.2, module version = 1.19.2
[    12.854] 	Module class: X.Org Video Driver
[    12.854] 	ABI class: X.Org Video Driver, version 23.0
[    12.854] (II) LoadModule: "fbdev"
[    12.855] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    12.859] (II) Module fbdev: vendor="X.Org Foundation"
[    12.859] 	compiled for 1.19.0, module version = 0.4.4
[    12.859] 	Module class: X.Org Video Driver
[    12.859] 	ABI class: X.Org Video Driver, version 23.0
[    12.859] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[    12.859] (II) FBDEV: driver for framebuffer: fbdev
[    12.953] (II) modeset(0): using drv /dev/dri/card0
[    12.953] (WW) Falling back to old probe method for fbdev
[    12.953] (II) Loading sub module "fbdevhw"
[    12.953] (II) LoadModule: "fbdevhw"
[    12.954] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    12.957] (II) Module fbdevhw: vendor="X.Org Foundation"
[    12.958] 	compiled for 1.19.2, module version = 0.0.2
[    12.958] 	ABI class: X.Org Video Driver, version 23.0
[    12.958] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card support
[    12.960] (II) modeset(0): Creating default Display subsection in Screen section
	"Default Screen Section" for depth/fbbpp 24/32
[    12.960] (==) modeset(0): Depth 24, (==) framebuffer bpp 32
[    12.960] (==) modeset(0): RGB weight 888
[    12.960] (==) modeset(0): Default visual is TrueColor
[    12.960] (II) Loading sub module "glamoregl"
[    12.960] (II) LoadModule: "glamoregl"
[    12.961] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    13.094] (II) Module glamoregl: vendor="X.Org Foundation"
[    13.094] 	compiled for 1.19.2, module version = 1.0.0
[    13.094] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    13.095] (II) glamor: OpenGL accelerated X.org driver based.
[    13.098] couldn't get display device
[    13.098] (EE) modeset(0): glamor initialization failed
[    13.098] (II) modeset(0): ShadowFB: preferred NO, enabled NO
[    13.624] (II) modeset(0): Output HDMI-1 has no monitor section
[    14.156] (II) modeset(0): EDID for output HDMI-1
[    14.156] (II) modeset(0): Manufacturer: AMA  Model: 3e0  Serial#: 1
[    14.156] (II) modeset(0): Year: 2005  Week: 21
[    14.156] (II) modeset(0): EDID Version: 1.3
[    14.157] (II) modeset(0): Digital Display Input
[    14.157] (II) modeset(0): Max Image Size [cm]: horiz.: 15  vert.: 5
[    14.157] (II) modeset(0): Gamma: 2.20
[    14.157] (II) modeset(0): No DPMS capabilities specified
[    14.157] (II) modeset(0): Supported color encodings: RGB 4:4:4 YCrCb 4:4:4 
[    14.157] (II) modeset(0): First detailed timing is preferred mode
[    14.157] (II) modeset(0): redX: 0.625 redY: 0.340   greenX: 0.284 greenY: 0.604
[    14.157] (II) modeset(0): blueX: 0.149 blueY: 0.064   whiteX: 0.280 whiteY: 0.311
[    14.157] (II) modeset(0): Supported established timings:
[    14.157] (II) modeset(0): 640x480@60Hz
[    14.157] (II) modeset(0): Manufacturer's mask: 0
[    14.158] (II) modeset(0): Supported detailed timing:
[    14.158] (II) modeset(0): clock: 20.9 MHz   Image Size:  149 x 54 mm
[    14.158] (II) modeset(0): h_active: 640  h_sync: 672  h_sync_end 672 h_blank_end 709 h_border: 0
[    14.158] (II) modeset(0): v_active: 480  v_sync: 484  v_sync_end 484 v_blanking: 491 v_border: 0
[    14.158] (II) modeset(0): Ranges: V min: 52 V max: 68 Hz, H min: 26 H max: 36 kHz, PixClock max 35 MHz
[    14.158] (II) modeset(0): EDID (in hex):
[    14.158] (II) modeset(0): 	00ffffffffffff0005a1e00301000000
[    14.158] (II) modeset(0): 	150f0103800f05780a0f6ea057489a26
[    14.158] (II) modeset(0): 	10474f20000001010101010101010101
[    14.158] (II) modeset(0): 	0101010101012a08804520e00b102000
[    14.158] (II) modeset(0): 	4000953600000018000000fd0034441a
[    14.158] (II) modeset(0): 	2403000a202020202020000000100031
[    14.159] (II) modeset(0): 	0a202020202020202020202000000010
[    14.159] (II) modeset(0): 	00002a4030701300782d1100001e006b
[    14.159] (WW) modeset(0): Output HDMI-1: Strange aspect ratio (149/54), consider adding a quirk
[    14.159] (II) modeset(0): Printing probed modes for output HDMI-1
[    14.159] (II) modeset(0): Modeline "640x480"x59.9   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[    14.159] (II) modeset(0): Output HDMI-1 connected
[    14.159] (II) modeset(0): Using exact sizes for initial modes
[    14.159] (II) modeset(0): Output HDMI-1 using initial mode 640x480 +0+0
[    14.159] (==) modeset(0): Using gamma correction (1.0, 1.0, 1.0)
[    14.159] (==) modeset(0): DPI set to (96, 96)
[    14.159] (II) Loading sub module "fb"
[    14.159] (II) LoadModule: "fb"
[    14.170] (II) Loading /usr/lib/xorg/modules/libfb.so
[    14.178] (II) Module fb: vendor="X.Org Foundation"
[    14.178] 	compiled for 1.19.2, module version = 1.0.0
[    14.178] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    14.178] (II) UnloadModule: "fbdev"
[    14.178] (II) Unloading fbdev
[    14.178] (II) UnloadSubModule: "fbdevhw"
[    14.179] (II) Unloading fbdevhw
[    14.179] (==) Depth 24 pixmap format is 32 bpp
[    14.191] (==) modeset(0): Backing store enabled
[    14.191] (==) modeset(0): Silken mouse enabled
[    14.191] (II) modeset(0): RandR 1.2 enabled, ignore the following RandR disabled message.
[    14.206] (==) modeset(0): DPMS enabled
[    14.206] (--) RandR disabled
[    14.275] (II) SELinux: Disabled on system
[    14.283] (II) AIGLX: Screen 0 is not DRI2 capable
[    14.283] (EE) AIGLX: reverting to software rendering
[    14.283] (EE) AIGLX error: dlopen of /usr/lib/arm-linux-gnueabihf/dri/swrast_dri.so failed (/usr/lib/arm-linux-gnueabihf/dri/swrast_dri.so: cannot open shared object file: No such file or directory)
[    14.283] (EE) GLX: could not load software renderer
[    14.283] (II) GLX: no usable GL providers found for screen 0
[    14.285] (II) modeset(0): Damage tracking initialized
[    14.285] (II) modeset(0): Setting screen physical size to 169 x 127
[    15.392] (II) config/udev: Adding input device axp20x-pek (/dev/input/event0)
[    15.393] (**) axp20x-pek: Applying InputClass "libinput keyboard catchall"
[    15.393] (II) LoadModule: "libinput"
[    15.396] (II) Loading /usr/lib/xorg/modules/input/libinput_drv.so
[    15.561] (II) Module libinput: vendor="X.Org Foundation"
[    15.561] 	compiled for 1.19.0, module version = 0.23.0
[    15.562] 	Module class: X.Org XInput Driver
[    15.562] 	ABI class: X.Org XInput driver, version 24.1
[    15.562] (II) Using input driver 'libinput' for 'axp20x-pek'
[    15.562] (**) axp20x-pek: always reports core events
[    15.563] (**) Option "Device" "/dev/input/event0"
[    15.565] (**) Option "_source" "server/udev"
[    15.572] (II) input device 'axp20x-pek', /dev/input/event0 is tagged by udev as: Keyboard
[    15.572] (II) input device 'axp20x-pek', /dev/input/event0 is a keyboard
[    15.611] (**) Option "config_info" "udev:/sys/devices/platform/soc/1c2ac00.i2c/i2c-1/1-0034/axp20x-pek/input/input0/event0"
[    15.611] (II) XINPUT: Adding extended input device "axp20x-pek" (type: KEYBOARD, id 6)
[    15.611] (**) Option "xkb_model" "pc105"
[    15.611] (**) Option "xkb_layout" "us"
[    15.625] (II) input device 'axp20x-pek', /dev/input/event0 is tagged by udev as: Keyboard
[    15.625] (II) input device 'axp20x-pek', /dev/input/event0 is a keyboard
[    19.217] (II) modeset(0): EDID vendor "AMA", prod id 992
[    19.217] (II) modeset(0): Using EDID range info for horizontal sync
[    19.217] (II) modeset(0): Using EDID range info for vertical refresh
[    19.217] (II) modeset(0): Printing DDC gathered Modelines:
[    19.217] (II) modeset(0): Modeline "640x480"x0.0   20.90  640 672 672 709  480 484 484 491 -hsync -vsync (29.5 kHz eP)
[    19.217] (II) modeset(0): Modeline "640x480"x0.0   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[    19.217] (WW) modeset(0): Output HDMI-1: Strange aspect ratio (149/54), consider adding a quirk
[    26.048] (II) modeset(0): Disabling kernel dirty updates, not required.

--fr3qwj52adqhjctl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Xorg.0-ddc-default.log"

[    11.067] 
X.Org X Server 1.19.2
Release Date: 2017-03-02
[    11.068] X Protocol Version 11, Revision 0
[    11.068] Build Operating System: Linux 4.9.0-8-armmp-lpae armv7l Debian
[    11.068] Current Operating System: Linux xxx-screen 5.0.0-rc1-00022-gd37dff96185c #77 SMP Fri Jan 18 11:26:03 EET 2019 armv7l
[    11.069] Kernel command line: console=ttyS0,115200n8 root=/dev/mmcblk0p1 rootwait debug
[    11.069] Build Date: 03 November 2018  05:53:43AM
[    11.069] xorg-server 2:1.19.2-1+deb9u5 (https://www.debian.org/support) 
[    11.070] Current version of pixman: 0.34.0
[    11.070] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[    11.070] Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    11.070] (==) Log file: "/var/log/Xorg.0.log", Time: Fri Jan 18 09:26:39 2019
[    11.090] (==) Using system config directory "/usr/share/X11/xorg.conf.d"
[    11.094] (==) No Layout section.  Using the first Screen section.
[    11.094] (==) No screen section available. Using defaults.
[    11.094] (**) |-->Screen "Default Screen Section" (0)
[    11.094] (**) |   |-->Monitor "<default monitor>"
[    11.099] (==) No monitor specified for screen "Default Screen Section".
	Using a default monitor configuration.
[    11.101] (==) Automatically adding devices
[    11.101] (==) Automatically enabling devices
[    11.101] (==) Automatically adding GPU devices
[    11.101] (==) Max clients allowed: 256, resource mask: 0x1fffff
[    11.103] (WW) The directory "/usr/share/fonts/X11/misc" does not exist.
[    11.103] 	Entry deleted from font path.
[    11.103] (WW) The directory "/usr/share/fonts/X11/cyrillic" does not exist.
[    11.103] 	Entry deleted from font path.
[    11.103] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not exist.
[    11.104] 	Entry deleted from font path.
[    11.104] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not exist.
[    11.105] 	Entry deleted from font path.
[    11.105] (WW) The directory "/usr/share/fonts/X11/Type1" does not exist.
[    11.105] 	Entry deleted from font path.
[    11.105] (WW) The directory "/usr/share/fonts/X11/100dpi" does not exist.
[    11.105] 	Entry deleted from font path.
[    11.105] (WW) The directory "/usr/share/fonts/X11/75dpi" does not exist.
[    11.105] 	Entry deleted from font path.
[    11.105] (==) FontPath set to:
	built-ins
[    11.105] (==) ModulePath set to "/usr/lib/xorg/modules"
[    11.105] (II) The server relies on udev to provide the list of input devices.
	If no devices become available, reconfigure udev or disable AutoAddDevices.
[    11.105] (II) Loader magic: 0x602f60
[    11.105] (II) Module ABI versions:
[    11.105] 	X.Org ANSI C Emulation: 0.4
[    11.105] 	X.Org Video Driver: 23.0
[    11.105] 	X.Org XInput driver : 24.1
[    11.105] 	X.Org Server Extension : 10.0
[    11.110] (++) using VT number 7

[    11.110] (II) systemd-logind: logind integration requires -keeptty and -keeptty was not provided, disabling logind integration
[    11.116] (II) xfree86: Adding drm device (/dev/dri/card0)
[    11.131] (II) no primary bus or device found
[    11.131] 	falling back to /sys/devices/platform/display-engine/drm/card0
[    11.132] (II) LoadModule: "glx"
[    11.136] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    11.257] (II) Module glx: vendor="X.Org Foundation"
[    11.257] 	compiled for 1.19.2, module version = 1.0.0
[    11.258] 	ABI class: X.Org Server Extension, version 10.0
[    11.258] (==) Matched modesetting as autoconfigured driver 0
[    11.258] (==) Matched fbdev as autoconfigured driver 1
[    11.258] (==) Assigned the driver to the xf86ConfigLayout
[    11.259] (II) LoadModule: "modesetting"
[    11.264] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
[    11.273] (II) Module modesetting: vendor="X.Org Foundation"
[    11.273] 	compiled for 1.19.2, module version = 1.19.2
[    11.273] 	Module class: X.Org Video Driver
[    11.273] 	ABI class: X.Org Video Driver, version 23.0
[    11.273] (II) LoadModule: "fbdev"
[    11.285] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    11.291] (II) Module fbdev: vendor="X.Org Foundation"
[    11.291] 	compiled for 1.19.0, module version = 0.4.4
[    11.291] 	Module class: X.Org Video Driver
[    11.292] 	ABI class: X.Org Video Driver, version 23.0
[    11.292] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[    11.293] (II) FBDEV: driver for framebuffer: fbdev
[    11.313] (II) modeset(0): using drv /dev/dri/card0
[    11.313] (WW) Falling back to old probe method for fbdev
[    11.314] (II) Loading sub module "fbdevhw"
[    11.314] (II) LoadModule: "fbdevhw"
[    11.315] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    11.319] (II) Module fbdevhw: vendor="X.Org Foundation"
[    11.319] 	compiled for 1.19.2, module version = 0.0.2
[    11.319] 	ABI class: X.Org Video Driver, version 23.0
[    11.319] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card support
[    11.324] (II) modeset(0): Creating default Display subsection in Screen section
	"Default Screen Section" for depth/fbbpp 24/32
[    11.325] (==) modeset(0): Depth 24, (==) framebuffer bpp 32
[    11.325] (==) modeset(0): RGB weight 888
[    11.325] (==) modeset(0): Default visual is TrueColor
[    11.325] (II) Loading sub module "glamoregl"
[    11.325] (II) LoadModule: "glamoregl"
[    11.332] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    11.931] (II) Module glamoregl: vendor="X.Org Foundation"
[    11.931] 	compiled for 1.19.2, module version = 1.0.0
[    11.932] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    11.932] (II) glamor: OpenGL accelerated X.org driver based.
[    11.937] couldn't get display device
[    11.937] (EE) modeset(0): glamor initialization failed
[    11.938] (II) modeset(0): ShadowFB: preferred NO, enabled NO
[    12.459] (II) modeset(0): Output HDMI-1 has no monitor section
[    13.017] (II) modeset(0): EDID for output HDMI-1
[    13.017] (II) modeset(0): Manufacturer: AMA  Model: 3e0  Serial#: 1
[    13.017] (II) modeset(0): Year: 2005  Week: 21
[    13.017] (II) modeset(0): EDID Version: 1.3
[    13.018] (II) modeset(0): Digital Display Input
[    13.018] (II) modeset(0): Max Image Size [cm]: horiz.: 15  vert.: 5
[    13.018] (II) modeset(0): Gamma: 2.20
[    13.018] (II) modeset(0): No DPMS capabilities specified
[    13.018] (II) modeset(0): Supported color encodings: RGB 4:4:4 YCrCb 4:4:4 
[    13.018] (II) modeset(0): First detailed timing is preferred mode
[    13.018] (II) modeset(0): redX: 0.625 redY: 0.340   greenX: 0.284 greenY: 0.604
[    13.018] (II) modeset(0): blueX: 0.149 blueY: 0.064   whiteX: 0.280 whiteY: 0.311
[    13.018] (II) modeset(0): Supported established timings:
[    13.018] (II) modeset(0): 640x480@60Hz
[    13.018] (II) modeset(0): Manufacturer's mask: 0
[    13.020] (II) modeset(0): Supported detailed timing:
[    13.020] (II) modeset(0): clock: 20.9 MHz   Image Size:  149 x 54 mm
[    13.020] (II) modeset(0): h_active: 640  h_sync: 672  h_sync_end 672 h_blank_end 709 h_border: 0
[    13.020] (II) modeset(0): v_active: 480  v_sync: 484  v_sync_end 484 v_blanking: 491 v_border: 0
[    13.020] (II) modeset(0): Ranges: V min: 52 V max: 68 Hz, H min: 26 H max: 36 kHz, PixClock max 35 MHz
[    13.020] (II) modeset(0): EDID (in hex):
[    13.020] (II) modeset(0): 	00ffffffffffff0005a1e00301000000
[    13.020] (II) modeset(0): 	150f0103800f05780a0f6ea057489a26
[    13.021] (II) modeset(0): 	10474f20000001010101010101010101
[    13.021] (II) modeset(0): 	0101010101012a08804520e00b102000
[    13.021] (II) modeset(0): 	4000953600000018000000fd0034441a
[    13.021] (II) modeset(0): 	2403000a202020202020000000100031
[    13.021] (II) modeset(0): 	0a202020202020202020202000000010
[    13.021] (II) modeset(0): 	00002a4030701300782d1100001e006b
[    13.021] (WW) modeset(0): Output HDMI-1: Strange aspect ratio (149/54), consider adding a quirk
[    13.021] (II) modeset(0): Printing probed modes for output HDMI-1
[    13.021] (II) modeset(0): Modeline "640x480"x59.9   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[    13.022] (II) modeset(0): Output HDMI-1 connected
[    13.022] (II) modeset(0): Using exact sizes for initial modes
[    13.022] (II) modeset(0): Output HDMI-1 using initial mode 640x480 +0+0
[    13.022] (==) modeset(0): Using gamma correction (1.0, 1.0, 1.0)
[    13.022] (==) modeset(0): DPI set to (96, 96)
[    13.022] (II) Loading sub module "fb"
[    13.022] (II) LoadModule: "fb"
[    13.044] (II) Loading /usr/lib/xorg/modules/libfb.so
[    13.068] (II) Module fb: vendor="X.Org Foundation"
[    13.068] 	compiled for 1.19.2, module version = 1.0.0
[    13.068] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    13.068] (II) UnloadModule: "fbdev"
[    13.068] (II) Unloading fbdev
[    13.069] (II) UnloadSubModule: "fbdevhw"
[    13.069] (II) Unloading fbdevhw
[    13.069] (==) Depth 24 pixmap format is 32 bpp
[    13.113] (==) modeset(0): Backing store enabled
[    13.114] (==) modeset(0): Silken mouse enabled
[    13.114] (II) modeset(0): RandR 1.2 enabled, ignore the following RandR disabled message.
[    13.119] (==) modeset(0): DPMS enabled
[    13.119] (--) RandR disabled
[    13.314] (II) SELinux: Disabled on system
[    13.355] (II) AIGLX: Screen 0 is not DRI2 capable
[    13.355] (EE) AIGLX: reverting to software rendering
[    13.356] (EE) AIGLX error: dlopen of /usr/lib/arm-linux-gnueabihf/dri/swrast_dri.so failed (/usr/lib/arm-linux-gnueabihf/dri/swrast_dri.so: cannot open shared object file: No such file or directory)
[    13.356] (EE) GLX: could not load software renderer
[    13.356] (II) GLX: no usable GL providers found for screen 0
[    13.357] (II) modeset(0): Damage tracking initialized
[    13.357] (II) modeset(0): Setting screen physical size to 169 x 127
[    14.479] (II) config/udev: Adding input device axp20x-pek (/dev/input/event0)
[    14.479] (**) axp20x-pek: Applying InputClass "libinput keyboard catchall"
[    14.479] (II) LoadModule: "libinput"
[    14.483] (II) Loading /usr/lib/xorg/modules/input/libinput_drv.so
[    14.536] (II) Module libinput: vendor="X.Org Foundation"
[    14.536] 	compiled for 1.19.0, module version = 0.23.0
[    14.536] 	Module class: X.Org XInput Driver
[    14.536] 	ABI class: X.Org XInput driver, version 24.1
[    14.536] (II) Using input driver 'libinput' for 'axp20x-pek'
[    14.536] (**) axp20x-pek: always reports core events
[    14.536] (**) Option "Device" "/dev/input/event0"
[    14.538] (**) Option "_source" "server/udev"
[    14.543] (II) input device 'axp20x-pek', /dev/input/event0 is tagged by udev as: Keyboard
[    14.543] (II) input device 'axp20x-pek', /dev/input/event0 is a keyboard
[    14.620] (**) Option "config_info" "udev:/sys/devices/platform/soc/1c2ac00.i2c/i2c-1/1-0034/axp20x-pek/input/input0/event0"
[    14.621] (II) XINPUT: Adding extended input device "axp20x-pek" (type: KEYBOARD, id 6)
[    14.621] (**) Option "xkb_model" "pc105"
[    14.621] (**) Option "xkb_layout" "us"
[    14.625] (II) input device 'axp20x-pek', /dev/input/event0 is tagged by udev as: Keyboard
[    14.625] (II) input device 'axp20x-pek', /dev/input/event0 is a keyboard
[    15.056] (II) config/udev: removing device axp20x-pek
[    15.130] (II) UnloadModule: "libinput"
[    15.133] (II) config/udev: Adding input device axp20x-pek (/dev/input/event0)
[    15.133] (**) axp20x-pek: Applying InputClass "libinput keyboard catchall"
[    15.133] (II) Using input driver 'libinput' for 'axp20x-pek'
[    15.133] (**) axp20x-pek: always reports core events
[    15.133] (**) Option "Device" "/dev/input/event0"
[    15.134] (**) Option "_source" "server/udev"
[    15.136] (II) input device 'axp20x-pek', /dev/input/event0 is tagged by udev as: Keyboard
[    15.136] (II) input device 'axp20x-pek', /dev/input/event0 is a keyboard
[    15.210] (**) Option "config_info" "udev:/sys/devices/platform/soc/1c2ac00.i2c/i2c-1/1-0034/axp20x-pek/input/input0/event0"
[    15.210] (II) XINPUT: Adding extended input device "axp20x-pek" (type: KEYBOARD, id 6)
[    15.210] (**) Option "xkb_model" "pc105"
[    15.210] (**) Option "xkb_layout" "us"
[    15.210] (WW) Option "xkb_variant" requires a string value
[    15.210] (WW) Option "xkb_options" requires a string value
[    15.214] (II) input device 'axp20x-pek', /dev/input/event0 is tagged by udev as: Keyboard
[    15.214] (II) input device 'axp20x-pek', /dev/input/event0 is a keyboard

--fr3qwj52adqhjctl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drm-debug-ddc-critical.log"

[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/mmcblk0p1 rootwait drm.debug=0xe
[    0.869019] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e60000
[    0.869079] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e40000
[    0.869126] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e60000
[    0.869168] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e40000
[    0.869211] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869259] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869303] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869416] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869461] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869503] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869545] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869587] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869636] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869683] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869727] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869770] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869814] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869876] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869920] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869964] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.870720] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.870814] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.870823] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871703] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.871712] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871721] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e60000
[    0.871789] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.871798] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871806] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e60000
[    0.871814] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/display-backend@1e60000
[    0.871823] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e40000
[    0.871831] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e40000
[    0.871839] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e40000
[    0.871847] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.871855] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871863] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e60000
[    0.871871] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/display-backend@1e60000
[    0.871880] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e40000
[    0.871888] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e40000
[    0.871896] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e40000
[    0.871904] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871912] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871920] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.871929] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871937] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871945] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.871953] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871961] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871969] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.871978] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871986] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871994] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.872002] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872010] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872018] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872026] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872327] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872336] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872345] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872353] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872361] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872370] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872378] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872386] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872394] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872402] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872410] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872418] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872426] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872434] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872441] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872450] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872457] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872465] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872473] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872481] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872489] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872497] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872505] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872513] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872521] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872529] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872537] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872545] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872552] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872560] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872568] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872576] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872584] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872592] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872600] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872608] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872616] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872624] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872632] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872639] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.883273] sun4i-drm display-engine: bound 1e60000.display-backend (ops 0xc0745b30)
[    0.901358] sun4i-drm display-engine: bound 1e40000.display-backend (ops 0xc0745b30)
[    0.909619] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    0.917461] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops 0xc07449e0)
[    0.925522] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    0.933397] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops 0xc07449e0)
[    0.941517] sun4i-drm display-engine: bound 1c16000.hdmi (ops 0xc074657c)
[    0.948304] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.954946] [drm] No driver support for vblank timestamp query.
[    0.960884] fb0: switching to sun4i-drm-fb from simple
[    0.972731] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
[    0.980594] [drm:drm_setup_crtcs] 
[    0.980613] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[    1.480951] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] status updated from unknown to connected
[    1.494201] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[    1.494216] [drm:drm_add_display_info] non_desktop set to 0
[    1.494254] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    1.494262] [drm:drm_add_display_info] non_desktop set to 0
[    1.494272] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[    1.494406] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[    1.494425] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    1.494436] [drm:drm_setup_crtcs] connector 57 enabled? yes
[    1.494446] [drm:drm_setup_crtcs] looking for cmdline mode on connector 57
[    1.494454] [drm:drm_setup_crtcs] looking for preferred mode on connector 57 0
[    1.494461] [drm:drm_setup_crtcs] found mode 640x480
[    1.494469] [drm:drm_setup_crtcs] picking CRTCs for 8192x8192 config
[    1.494486] [drm:drm_setup_crtcs] desired mode 640x480 set on crtc 42 (0,0)
[    1.494506] [drm:drm_fb_helper_generic_probe] surface width(640), height(480) and bpp(32)
[    1.495849] [drm:drm_mode_addfb2] [FB:61]
[    1.496567] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.496582] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    1.496595] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    1.496601] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    1.496611] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    1.496617] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.496989] [drm:sun4i_tcon_get_clk_delay] TCON 1 clock delay 30
[    1.497002] [drm:sun4i_tcon_mode_set] Setting horizontal total 800, backporch 144
[    1.497009] [drm:sun4i_tcon_mode_set] Setting vertical total 525, backporch 35
[    1.497015] [drm:sun4i_tcon_mode_set] Setting HSYNC 96, VSYNC 2
[    1.497026] [drm:sun4i_tcon_set_mux] Muxing encoder TMDS-56 to CRTC crtc-0: 0
[    1.497265] [drm:sun4i_crtc_atomic_enable] Enabling the CRTC
[    1.497289] [drm:sun4i_hdmi_enable] Enabling the HDMI Output
[    1.497315] [drm:sun4i_crtc_enable_vblank] Enabling VBLANK on crtc (ptrval)
[    1.497321] [drm:sun4i_tcon_enable_vblank] Enabling VBLANK interrupt
[    1.497343] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    1.497354] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    1.497364] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    1.497371] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    1.497378] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    1.497386] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    1.497394] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    1.497401] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    1.497408] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    1.497416] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    1.497423] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    1.497431] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    1.497437] [drm:sun4i_backend_commit] Committing changes
[    1.514188] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.514201] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    1.514212] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    1.514218] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    1.514227] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    1.514233] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.514279] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    1.514289] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    1.514299] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    1.514306] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    1.514313] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    1.514320] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    1.514328] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    1.514335] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    1.514342] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    1.514350] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    1.514357] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    1.514363] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    1.514368] [drm:sun4i_backend_commit] Committing changes
[    1.535150] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.535161] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    1.535170] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    1.535176] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    1.535184] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    1.535190] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.535225] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    1.535234] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    1.535242] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    1.535249] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    1.535255] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    1.535262] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    1.535269] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    1.535277] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    1.535284] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    1.535291] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    1.535298] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    1.535305] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    1.535310] [drm:sun4i_backend_commit] Committing changes
[    1.557982] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
[    6.569451] [drm:sun4i_crtc_disable_vblank] Disabling VBLANK on crtc (ptrval)
[    6.569471] [drm:sun4i_tcon_enable_vblank] Disabling VBLANK interrupt
[    7.926797] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.926823] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    7.926836] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    7.926843] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    7.926853] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    7.926860] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.926919] [drm:sun4i_crtc_enable_vblank] Enabling VBLANK on crtc (ptrval)
[    7.926927] [drm:sun4i_tcon_enable_vblank] Enabling VBLANK interrupt
[    7.926963] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    7.926974] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    7.926985] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    7.926993] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    7.927001] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    7.927009] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    7.927017] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    7.927024] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    7.927032] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    7.927040] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    7.927049] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    7.927057] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    7.927063] [drm:sun4i_backend_commit] Committing changes
[    7.948942] sun4i-drm display-engine: [drm:drm_client_dev_restore] fbdev: ret=0
[    8.142544] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    8.142567] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    8.142579] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    8.142585] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    8.142595] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    8.142601] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    8.142675] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    8.142686] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    8.142698] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    8.142706] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    8.142713] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    8.142720] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    8.142728] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    8.142735] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    8.142742] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    8.142750] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    8.142758] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    8.142765] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    8.142771] [drm:sun4i_backend_commit] Committing changes
[    8.160539] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    8.160564] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    8.160577] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    8.160585] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    8.160595] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    8.160603] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    8.160676] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    8.160689] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    8.160702] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    8.160710] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    8.160718] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    8.160726] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    8.160734] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    8.160742] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    8.160749] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    8.160758] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    8.160767] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    8.160775] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    8.160781] [drm:sun4i_backend_commit] Committing changes
[    8.176373] sun4i-drm display-engine: [drm:drm_client_dev_restore] fbdev: ret=0
[    8.189826] [drm:drm_mode_addfb2] [FB:62]
[    8.421597] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[    8.951353] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[    8.951380] [drm:drm_add_display_info] non_desktop set to 0
[    8.951416] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    8.951424] [drm:drm_add_display_info] non_desktop set to 0
[    8.951435] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[    8.951548] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[    8.951569] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    8.954545] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[    9.474794] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[    9.474822] [drm:drm_add_display_info] non_desktop set to 0
[    9.474862] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    9.474871] [drm:drm_add_display_info] non_desktop set to 0
[    9.474883] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[    9.475004] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[    9.475026] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    9.520408] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    9.520486] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    9.520496] [drm:sun4i_backend_commit] Committing changes
[   10.419550] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   10.419619] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   10.419628] [drm:sun4i_backend_commit] Committing changes
[   10.432854] [drm:drm_mode_addfb2] [FB:62]
[   10.432895] [drm:drm_mode_setcrtc] [CRTC:42:crtc-0]
[   10.432945] [drm:drm_mode_setcrtc] [CONNECTOR:57:HDMI-A-1]
[   10.433037] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   10.433050] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[   10.433063] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[   10.433070] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[   10.433081] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[   10.433148] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[   10.433160] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[   10.433174] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a300000
[   10.433181] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x51800000
[   10.433188] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[   10.433196] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[   10.433204] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[   10.433211] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[   10.433219] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[   10.433227] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[   10.433236] [drm:sun4i_backend_layer_enable] Enabling layer 0
[   10.433244] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   10.433250] [drm:sun4i_backend_commit] Committing changes
[   10.447284] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   10.448031] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   10.448041] [drm:sun4i_backend_commit] Committing changes
[   10.463849] [drm:drm_mode_setcrtc] [CRTC:55:crtc-1]
[   10.463912] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   11.870275] sun4i-drm display-engine: [drm:drm_client_dev_hotplug] fbdev: ret=0
[   11.879623] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[   12.397463] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[   12.397488] [drm:drm_add_display_info] non_desktop set to 0
[   12.397522] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[   12.397530] [drm:drm_add_display_info] non_desktop set to 0
[   12.397541] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[   12.397645] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[   12.397664] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[   15.529370] [drm:sun4i_crtc_disable_vblank] Disabling VBLANK on crtc (ptrval)
[   15.529390] [drm:sun4i_tcon_enable_vblank] Disabling VBLANK interrupt
[   16.307851] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   16.307906] [drm:sun4i_crtc_enable_vblank] Enabling VBLANK on crtc (ptrval)
[   16.307913] [drm:sun4i_tcon_enable_vblank] Enabling VBLANK interrupt
[   16.307967] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   16.307974] [drm:sun4i_backend_commit] Committing changes
[   21.369372] [drm:sun4i_crtc_disable_vblank] Disabling VBLANK on crtc (ptrval)
[   21.369389] [drm:sun4i_tcon_enable_vblank] Disabling VBLANK interrupt

--fr3qwj52adqhjctl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drm-debug-ddc-default.log"

[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/mmcblk0p1 rootwait drm.debug=0xe
[    0.868874] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e60000
[    0.868932] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e40000
[    0.868979] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e60000
[    0.869021] [drm:sun4i_drv_probe] Adding component /soc/display-backend@1e40000
[    0.869063] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869111] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869156] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869198] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869240] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869347] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869392] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0c000
[    0.869435] [drm:sun4i_drv_probe] Adding component /soc/lcd-controller@1c0d000
[    0.869486] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869533] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869577] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869620] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869664] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869725] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869769] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.869813] [drm:sun4i_drv_probe] Adding component /soc/hdmi@1c16000
[    0.870568] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.870659] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.870668] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871553] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.871562] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871572] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e60000
[    0.871636] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.871645] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871653] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e60000
[    0.871661] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/display-backend@1e60000
[    0.871670] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e40000
[    0.871678] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e40000
[    0.871686] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e40000
[    0.871695] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e60000
[    0.871703] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e60000
[    0.871711] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e60000
[    0.871719] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/display-backend@1e60000
[    0.871727] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/display-backend@1e40000
[    0.871735] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/display-backend@1e40000
[    0.871743] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/display-backend@1e40000
[    0.871751] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871760] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871767] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.871776] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871784] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871792] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.871800] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871808] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871817] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.871825] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0c000
[    0.871833] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/lcd-controller@1c0d000
[    0.871841] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/lcd-controller@1c0d000
[    0.871849] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.871857] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.871865] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.871873] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872173] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872183] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872192] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872200] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872207] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872215] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872224] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872232] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872240] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872247] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872255] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872263] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872271] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872279] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872287] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872295] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872303] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872311] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872318] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872326] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872334] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872342] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872350] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872358] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872365] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872373] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872381] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872389] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872397] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872405] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872413] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872421] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872428] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872436] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872444] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.872452] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0c000 with /soc/hdmi@1c16000
[    0.872460] [drm:compare_of] Comparing of node /soc/lcd-controller@1c0d000 with /soc/hdmi@1c16000
[    0.872468] [drm:compare_of] Comparing of node /soc/display-backend@1e40000 with /soc/hdmi@1c16000
[    0.872476] [drm:compare_of] Comparing of node /soc/display-backend@1e60000 with /soc/hdmi@1c16000
[    0.872484] [drm:compare_of] Comparing of node /soc/hdmi@1c16000 with /soc/hdmi@1c16000
[    0.883130] sun4i-drm display-engine: bound 1e60000.display-backend (ops 0xc0745b30)
[    0.901221] sun4i-drm display-engine: bound 1e40000.display-backend (ops 0xc0745b30)
[    0.909485] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    0.917327] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops 0xc07449e0)
[    0.925357] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    0.933235] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops 0xc07449e0)
[    0.941347] sun4i-drm display-engine: bound 1c16000.hdmi (ops 0xc074657c)
[    0.948135] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.954783] [drm] No driver support for vblank timestamp query.
[    0.960719] fb0: switching to sun4i-drm-fb from simple
[    0.972566] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
[    0.980418] [drm:drm_setup_crtcs] 
[    0.980436] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[    1.480776] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] status updated from unknown to connected
[    1.494100] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[    1.494115] [drm:drm_add_display_info] non_desktop set to 0
[    1.494152] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    1.494160] [drm:drm_add_display_info] non_desktop set to 0
[    1.494171] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[    1.494303] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[    1.494321] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    1.494333] [drm:drm_setup_crtcs] connector 57 enabled? yes
[    1.494343] [drm:drm_setup_crtcs] looking for cmdline mode on connector 57
[    1.494351] [drm:drm_setup_crtcs] looking for preferred mode on connector 57 0
[    1.494358] [drm:drm_setup_crtcs] found mode 640x480
[    1.494365] [drm:drm_setup_crtcs] picking CRTCs for 8192x8192 config
[    1.494381] [drm:drm_setup_crtcs] desired mode 640x480 set on crtc 42 (0,0)
[    1.494399] [drm:drm_fb_helper_generic_probe] surface width(640), height(480) and bpp(32)
[    1.495746] [drm:drm_mode_addfb2] [FB:61]
[    1.496467] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.496482] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    1.496494] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    1.496500] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    1.496510] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    1.496516] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.496888] [drm:sun4i_tcon_get_clk_delay] TCON 1 clock delay 30
[    1.496901] [drm:sun4i_tcon_mode_set] Setting horizontal total 800, backporch 144
[    1.496908] [drm:sun4i_tcon_mode_set] Setting vertical total 525, backporch 35
[    1.496915] [drm:sun4i_tcon_mode_set] Setting HSYNC 96, VSYNC 2
[    1.496925] [drm:sun4i_tcon_set_mux] Muxing encoder TMDS-56 to CRTC crtc-0: 0
[    1.497159] [drm:sun4i_crtc_atomic_enable] Enabling the CRTC
[    1.497184] [drm:sun4i_hdmi_enable] Enabling the HDMI Output
[    1.497213] [drm:sun4i_crtc_enable_vblank] Enabling VBLANK on crtc (ptrval)
[    1.497219] [drm:sun4i_tcon_enable_vblank] Enabling VBLANK interrupt
[    1.497240] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    1.497252] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    1.497262] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    1.497269] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    1.497276] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    1.497284] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    1.497291] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    1.497298] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    1.497305] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    1.497314] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    1.497321] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    1.497329] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    1.497336] [drm:sun4i_backend_commit] Committing changes
[    1.514075] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.514091] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    1.514102] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    1.514108] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    1.514116] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    1.514122] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.514168] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    1.514178] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    1.514188] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    1.514195] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    1.514201] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    1.514209] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    1.514216] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    1.514223] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    1.514230] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    1.514238] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    1.514245] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    1.514252] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    1.514257] [drm:sun4i_backend_commit] Committing changes
[    1.535058] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.535068] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    1.535078] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    1.535084] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    1.535093] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    1.535098] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    1.535136] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    1.535145] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    1.535154] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    1.535160] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    1.535167] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    1.535175] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    1.535182] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    1.535189] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    1.535196] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    1.535203] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    1.535211] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    1.535217] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    1.535222] [drm:sun4i_backend_commit] Committing changes
[    1.557882] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
[    6.569370] [drm:sun4i_crtc_disable_vblank] Disabling VBLANK on crtc (ptrval)
[    6.569388] [drm:sun4i_tcon_enable_vblank] Disabling VBLANK interrupt
[    7.662711] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.662734] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    7.662747] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    7.662753] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    7.662763] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    7.662769] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.662830] [drm:sun4i_crtc_enable_vblank] Enabling VBLANK on crtc (ptrval)
[    7.662837] [drm:sun4i_tcon_enable_vblank] Enabling VBLANK interrupt
[    7.662906] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    7.662919] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    7.662931] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    7.662938] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    7.662945] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    7.662953] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    7.662961] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    7.662968] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    7.662975] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    7.662983] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    7.662991] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    7.662999] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    7.663004] [drm:sun4i_backend_commit] Committing changes
[    7.816667] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.816719] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    7.816734] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    7.816741] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    7.816751] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    7.816758] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.816849] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    7.816865] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    7.816878] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    7.816885] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    7.816893] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    7.816901] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    7.816909] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    7.816917] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    7.816924] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    7.816933] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    7.816942] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    7.816950] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    7.816957] [drm:sun4i_backend_commit] Committing changes
[    7.826574] sun4i-drm display-engine: [drm:drm_client_dev_restore] fbdev: ret=0
[    7.971174] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.971196] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    7.971210] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    7.971216] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    7.971226] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    7.971233] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.971314] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    7.971341] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    7.971357] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    7.971365] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    7.971372] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    7.971381] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    7.971389] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    7.971396] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    7.971403] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    7.971412] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    7.971421] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    7.971429] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    7.971435] [drm:sun4i_backend_commit] Committing changes
[    7.988113] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.988141] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[    7.988156] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[    7.988163] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[    7.988173] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[    7.988181] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    7.988261] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[    7.988274] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[    7.988288] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a100000
[    7.988296] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x50800000
[    7.988304] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[    7.988312] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[    7.988321] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[    7.988328] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[    7.988336] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[    7.988344] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[    7.988352] [drm:sun4i_backend_layer_enable] Enabling layer 0
[    7.988360] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    7.988367] [drm:sun4i_backend_commit] Committing changes
[    7.992636] sun4i-drm display-engine: [drm:drm_client_dev_restore] fbdev: ret=0
[    8.011383] [drm:drm_mode_addfb2] [FB:63]
[    8.225405] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[    8.756238] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[    8.756266] [drm:drm_add_display_info] non_desktop set to 0
[    8.756309] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    8.756317] [drm:drm_add_display_info] non_desktop set to 0
[    8.756329] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[    8.756442] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[    8.756462] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    8.757415] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[    9.274430] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[    9.274464] [drm:drm_add_display_info] non_desktop set to 0
[    9.274509] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    9.274517] [drm:drm_add_display_info] non_desktop set to 0
[    9.274530] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[    9.274653] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[    9.274678] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    9.314157] [drm:sun4i_backend_atomic_check] Starting checking our planes
[    9.314225] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[    9.314235] [drm:sun4i_backend_commit] Committing changes
[   10.139082] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   10.139150] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   10.139159] [drm:sun4i_backend_commit] Committing changes
[   10.147346] [drm:drm_mode_addfb2] [FB:63]
[   10.147389] [drm:drm_mode_setcrtc] [CRTC:42:crtc-0]
[   10.147437] [drm:drm_mode_setcrtc] [CONNECTOR:57:HDMI-A-1]
[   10.147535] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   10.147551] [drm:sun4i_backend_plane_uses_scaler] Input size 640x480, output size 640x480
[   10.147565] [drm:sun4i_backend_atomic_check] Plane FB format is XR24 little-endian (0x34325258)
[   10.147572] [drm:sun4i_backend_atomic_check] Plane zpos is 0
[   10.147584] [drm:sun4i_backend_atomic_check] State valid with 1 planes, 0 alpha, 0 video, 0 YUV
[   10.147650] [drm:sun4i_backend_update_layer_formats] Switching display backend interlaced mode off
[   10.147663] [drm:sun4i_backend_update_layer_buffer] Layer line width: 20480 bits
[   10.147676] [drm:sun4i_backend_update_layer_buffer] Setting buffer address to 0x4a300000
[   10.147684] [drm:sun4i_backend_update_layer_buffer] Setting address lower bits to 0x51800000
[   10.147692] [drm:sun4i_backend_update_layer_buffer] Setting address high bits to 0x0
[   10.147700] [drm:sun4i_backend_update_layer_coord] Updating layer 0
[   10.147708] [drm:sun4i_backend_update_layer_coord] Primary layer, updating global size W: 640 H: 480
[   10.147715] [drm:sun4i_backend_update_layer_coord] Layer size W: 640 H: 480
[   10.147723] [drm:sun4i_backend_update_layer_coord] Layer coordinates X: 0 Y: 0
[   10.147731] [drm:sun4i_backend_update_layer_zpos] Setting layer 0's priority to 0 and pipe 0
[   10.147739] [drm:sun4i_backend_layer_enable] Enabling layer 0
[   10.147750] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   10.147757] [drm:sun4i_backend_commit] Committing changes
[   10.163329] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   10.164071] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   10.164080] [drm:sun4i_backend_commit] Committing changes
[   10.179889] [drm:drm_mode_setcrtc] [CRTC:55:crtc-1]
[   10.179955] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   11.870178] sun4i-drm display-engine: [drm:drm_client_dev_hotplug] fbdev: ret=0
[   11.879581] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1]
[   12.397422] [drm:sun4i_hdmi_get_modes] Monitor is a DVI monitor
[   12.397446] [drm:drm_add_display_info] non_desktop set to 0
[   12.397478] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[   12.397486] [drm:drm_add_display_info] non_desktop set to 0
[   12.397497] [drm:drm_for_each_detailed_block.part.0] Incorrect Detailed timing. Wrong Hsync/Vsync pulse width
[   12.397602] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:57:HDMI-A-1] probed modes :
[   12.397620] [drm:drm_mode_debug_printmodeline] Modeline 59:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
[   15.209309] [drm:sun4i_crtc_disable_vblank] Disabling VBLANK on crtc (ptrval)
[   15.209327] [drm:sun4i_tcon_enable_vblank] Disabling VBLANK interrupt
[   16.091530] [drm:sun4i_backend_atomic_check] Starting checking our planes
[   16.091586] [drm:sun4i_crtc_enable_vblank] Enabling VBLANK on crtc (ptrval)
[   16.091594] [drm:sun4i_tcon_enable_vblank] Enabling VBLANK interrupt
[   16.091647] [drm:sun4i_crtc_atomic_flush] Committing plane changes
[   16.091654] [drm:sun4i_backend_commit] Committing changes
[   21.129382] [drm:sun4i_crtc_disable_vblank] Disabling VBLANK on crtc (ptrval)
[   21.129398] [drm:sun4i_tcon_enable_vblank] Disabling VBLANK interrupt

--fr3qwj52adqhjctl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--fr3qwj52adqhjctl--

