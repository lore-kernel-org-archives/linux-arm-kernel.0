From: moon.linux@yahoo.com (Anand Moon)
Date: Wed, 7 Jan 2015 18:37:48 +0000 (UTC)
Subject: [PATCH v2] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1420470469.15910.134.camel@collabora.co.uk>
References: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <54AA48E6.3040404@samsung.com> <1420470469.15910.134.camel@collabora.co.uk>
Message-ID: <69242715.30115.1420655868687.JavaMail.yahoo@jws10659.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

I am using 3.18.0 kernel on my odroidxu3 board.
Using exynos_defconfig I am able to boot the board.

Are you able to get all the 8 core CPU up and running ?


Only 4 core cpu's are on my board. Also CpuFreq is not working.

Can you share some point on this.


root at odroid-xu3:/usr/src/odroidxu3-3.18.y-debug# cat /proc/cpuinfo | grep processor
processor : 0
processor : 5
processor : 6
processor : 7


Below are the logs of the board.

[    9.720905] Registering SWP/SWPB emulation handler
[    9.725457] big.LITTLE switcher initializing
[    9.729518] CPU0 paired with CPU4
[    9.732805] CPU5 paired with CPU3
[    9.736069] CPU6 paired with CPU2
[    9.739386] CPU7 paired with CPU1
[    9.742688] GIC ID for CPU 0 cluster 1 is 4
[    9.746816] GIC ID for CPU 0 cluster 0 is 0
[    9.800575] IRQ153 no longer affine to CPU1
[    9.803065] CPU1: shutdown
[    9.813482] GIC ID for CPU 1 cluster 0 is 1
[    9.869776] IRQ154 no longer affine to CPU2
[    9.872218] CPU2: shutdown
[    9.879985] GIC ID for CPU 2 cluster 0 is 2
[    9.924656] IRQ155 no longer affine to CPU3
[    9.927094] CPU3: shutdown
[    9.935544] GIC ID for CPU 3 cluster 0 is 3
[    9.989578] IRQ160 no longer affine to CPU4
[    9.991787] CPU4: shutdown
[   10.001003] GIC ID for CPU 1 cluster 1 is 5
[   10.003812] GIC ID for CPU 2 cluster 1 is 6
[   10.007976] GIC ID for CPU 3 cluster 1 is 7
[   10.015308] big.LITTLE switcher initialized
[   10.031368] registered taskstats version 1
[   10.038110] pinctrl core: add 2 pinmux maps
[   10.038374] samsung-pinctrl 13400000.pinctrl: found group selector 39 for gpx3-7
[   10.038541] samsung-pinctrl 13400000.pinctrl: found group selector 39 for gpx3-7
[   10.038586] samsung-pinctrl 13400000.pinctrl: request pin 39 (gpx3-7) for 14530000.hdmi
[   10.039440] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of node '/hdmi at 14530000[0]' - status (0)
[   10.040227] exynos-hdmi 14530000.hdmi: Looking up vdd-supply from device tree
[   10.042869] exynos-hdmi 14530000.hdmi: Looking up vdd_osc-supply from device tree
[   10.044700] exynos-hdmi 14530000.hdmi: Looking up vdd_pll-supply from device tree
[   10.046528] exynos-hdmi 14530000.hdmi: Looking up hdmi-en-supply from device tree
[   10.046558] exynos-hdmi 14530000.hdmi: Looking up hdmi-en-supply property in node /hdmi at 14530000 failed
[   10.048281] samsung-pinctrl 13400000.pinctrl: request pin 39 (gpx3-7) for gpx3:39
[   10.071915] exynos-mixer 14450000.mixer: probe start
[   10.076942] exynos-sysmmu 14650000.sysmmu: Enabled
[   10.076975] exynos-mixer 14450000.mixer: exynos_iommu_attach_device: Attached IOMMU with pgtable 0x42264000
[   10.077570] exynos-drm exynos-drm: bound 14450000.mixer (ops mixer_component_ops)
[   10.089655] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_component_ops)
[   10.095639] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.102242] [drm] No driver support for vblank timestamp query.
[   10.161814] cma: cma_alloc(cma c11c3218, count 2025, align 8)
[   10.256074] cma: cma_alloc(): returned ef6cd400
[   10.457934] Console: switching to colour frame buffer device 274x77
[   10.511095] exynos-drm exynos-drm: fb0:  frame buffer device
[   10.516212] exynos-drm exynos-drm: registered panic notifier
[   10.537871] [drm] Initialized exynos 1.0.0 20110530 on minor 0
[   10.545873] s3c-rtc 101e0000.rtc: setting system clock to 2015-01-07 17:50:09 UTC (1420653009)
[   10.553979] power-domain: Power-off latency exceeded, new value 388375 ns
[   10.560076] power-domain: Power-off latency exceeded, new value 6221750 ns
[   10.567225] power-domain: Power-off latency exceeded, new value 248791 ns
[   10.573666] power-domain: Power-off latency exceeded, new value 6502916 ns
[   11.093083] MAIN_DC: disabling
[   11.099738] ALSA device list:
[   11.101347]   No soundcards found.
[   11.117975] Freeing unused kernel memory: 1732K (c079b000 - c094c000)
[   11.775702] systemd-udevd[1676]: starting version 204
[   15.298783] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[   17.878286] init: plymouth-upstart-bridge main process (1732) terminated with status 1
[   17.885458] init: plymouth-upstart-bridge main process ended, respawning
[   18.211733] init: plymouth-upstart-bridge main process (1741) terminated with status 1
[   18.219007] init: plymouth-upstart-bridge main process ended, respawning
[   18.432104] init: plymouth-upstart-bridge main process (1745) terminated with status 1
[   18.439365] init: plymouth-upstart-bridge main process ended, respawning
[   22.612268] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=remount-ro
[   26.072597] systemd-udevd[1923]: starting version 204
[   32.854190] Bluetooth: Core ver 2.19
[   32.856710] NET: Registered protocol family 31
[   32.856733] Bluetooth: HCI device and connection manager initialized
[   32.857604] Bluetooth: HCI socket layer initialized
[   32.877598] Bluetooth: L2CAP socket layer initialized
[   32.879515] Bluetooth: SCO socket layer initialized
[   33.282331] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   33.282356] Bluetooth: BNEP filters: protocol multicast
[   33.282600] Bluetooth: BNEP socket layer initialized
[   33.371899] _cpu_up: attempt to bring up CPU 2 failed
[   33.380836] Bluetooth: RFCOMM TTY layer initialized
[   33.381088] Bluetooth: RFCOMM socket layer initialized
[   33.381439] Bluetooth: RFCOMM ver 1.11
[   33.410276] _cpu_up: attempt to bring up CPU 3 failed
[   33.414848] _cpu_up: attempt to bring up CPU 4 failed
[   33.419857] _cpu_up: attempt to bring up CPU 1 failed
[   38.518916] NET: Registered protocol family 10
[   46.590494] init: failsafe main process (2550) killed by TERM signal
[   50.596528] smsc95xx 5-1.1:1.0 eth0: hardware isn't capable of remote wakeup


-Anand Moon



On Monday, January 5, 2015 9:00 PM, Sjoerd Simons <sjoerd.simons@collabora.co.uk> wrote:
On Mon, 2015-01-05 at 17:18 +0900, Joonyoung Shim wrote:
> Hi Sjoerd,
> 
> On 12/05/2014 04:27 AM, Sjoerd Simons wrote:
> > Add DTS for the Hardkernel Odroid XU3. The name of the DTS file is kept the
> > same as the vendors naming, which means it's prefixed with exynos5422
> > instead of exynos5800 as the SoC name even though it includes the
> > exyno5800 dtsi.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> > Changes since v1:
> >   * Add chosen/linux,stdout-path to point the serial console device
> >   * Change memory start offset to 0x40000000 to match the vendors DTS (pointed
> >     out by Heesub Shin)
> >   * Declare base address & size for the memory banks to be used by the MFC
> > 
> > Kevin, Tyler, even though the changes are small i didn't want to just stick
> > your Tested-By on. Could you both be so kind to retest this on your XU3's ?
> > 
> > Heesub, I would still love to know the reason for having the memory start
> > address at 0x40000000 for this board?
> > 
> >  arch/arm/boot/dts/Makefile                 |   1 +
> >  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 332 +++++++++++++++++++++++++++++
> >  2 files changed, 333 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 38c89ca..0a898cc 100644


> > +
> > +&hdmi {
> > +    status = "okay";
> > +    hpd-gpio = <&gpx3 7 0>;
> > +    pinctrl-names = "default";
> > +    pinctrl-0 = <&hdmi_hpd_irq>;
> > +
> > +    vdd_osc-supply = <&ldo10_reg>;
> > +    vdd_pll-supply = <&ldo8_reg>;
> > +    vdd-supply = <&ldo8_reg>;
> 
> ldo10 and ldo8 are right? I think ldo7 and ldo6 are related with hdmi
> from schematic.

Nice catch. I followed hardkernels dts here, which refers to ldo10 &
ldo8, however double-checking the schematics indeed indicate that ldo7
and ldo6 are used the HDMI supplies. 

I'll do some testing and follow-up

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
