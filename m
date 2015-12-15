From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 21:40:29 +0100
Subject: [PATCH v5 2/2] arm: pxa27x: support for ICP DAS LP-8x4x w/ DT
In-Reply-To: <8760zziiqo.fsf@belgarion.home>
References: <1449700088-28076-3-git-send-email-ynvich@gmail.com>
 <4511402.o53nMsg37l@wuerfel> <8760zziiqo.fsf@belgarion.home>
Message-ID: <4654862.9oa8E6Ag38@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 21:01:35 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Tuesday 15 December 2015 21:50:13 Sergei Ianovich wrote:
> >> On Tue, 2015-12-15 at 19:06 +0100, Robert Jarzmik wrote:
> >> Updated plan:
> >> 1. MACH_PXA27X_DT
> >> 2. PXA_FB and 8250_PXA to enable console
> What about gpio-pxa ? And maybe pinctrl-pxa27x (only in linux-next by now) ? Can
> a pxafb work without gpio-pxa ? Also usually for pxafb you have pwm and pwm_bl
> to see something.
> 
> >> 3. MMC, MMC_PXA and EXT4_FS to enable boot from MMC
> >> 3.1. MTD, MTD_CFI, MTD_PHYSMAP_OF and JFFS2_FS to enable boot from MTD
> Ok. Is pxa2xx-pcmcia out of scope ? I seem to remember we have several boards
> where pcmcia is the rootfs (even if that is a small mess right now I still have
> to work on). Or do we consider pcmcia as obsolete ?

I'm definitely fine with tossing in everything that is PXA specific,
even if it's rarely used.

If someone wants a smaller kernel, they can still start out with the
defconfig and disable stuff they don't need, which tends to be easier
than the opposite, and it gives us compile-time coverage with the
autobuilders that compile every defconfig.

	Arnd
