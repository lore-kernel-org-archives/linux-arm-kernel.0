From: imp@bsdimp.com (M. Warner Losh)
Date: Wed, 16 Jun 2010 00:52:37 -0600 (MDT)
Subject: Request review of device tree documentation
In-Reply-To: <4C187013.5000400@firmworks.com>
References: <4C186B7B.1060308@firmworks.com> <4C186C72.2020506@compulab.co.il>
	<4C187013.5000400@firmworks.com>
Message-ID: <20100616.005237.338122493954307067.imp@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In message: <4C187013.5000400@firmworks.com>
            Mitch Bradley <wmb@firmworks.com> writes:
: Mike Rapoport wrote:
: > Mitch Bradley wrote:
: >> Mike Rapoport wrote:
: >>> Mitch Bradley wrote:
: >>>
: >>>> The second topic is the hypothetical use of OFW as a HAL. That will
: >>>> not happen for several reasons.  The opposition to the idea is
: >>>> widespread and deeply held, and there are good arguments to support
: >>>> that opposition.  Furthermore, the economic conditions necessary for
: >>>> the creation of such a HAL do not exist in the ARM world, nor indeed
: >>>> in the Linux world in general.  (The necessary condition is the
: >>>> ability for one company to impose a substantial change by fiat -
: >>>> essentially a monopoly position.)
: >>>>
: >>>> Shall we agree, then, that any further discussion of the HAL issue is
: >>>> "just for fun", and that nobody needs to feel threatened that it would
: >>>> actually happen?
: >>>
: >>> I've recently worked with vendor versions of U-Boot for advanced ARM
: >>> SoCs. There is already *huge* chunk of HAL code in those versions. And
: >>> if there would be possibility to have callbacks into the firmware
: >>> these chunks would only grow, IMHO.
: >>
: >> How can there be HAL code in U-Boot unless there is already the
: >> possibility to have callbacks into the firmware?
: >
: > Currently it aims to abstract hardware from U-Boot and reuse the same
: > HW access code across operating systems and bootloaders. If this code
: > would have callbacks I afraid the things would became worse.
: 
: The only way I can understand what you said is if I assume that by
: "callback", you mean the following sequence:
: 
: a) U-boot loads and executes the OS, providing to the OS the address
: of some HW access routines that it can use
: b) The OS calls one of those HW access routines
: c) During the execution of that HW access routine, that routine calls
: "back" into the OS, before returning.  So a call into the OS is nested
: inside a call into U-boot resident code.
: 
: If that is what you are worried about, it is not what we were
: discussing.  We were discussing - and many people were against - step
: (b).
: 
: Are you saying that step (b) - the OS calling into routines provided
: by U-Boot - is already the status quo?

I don't know about status quo, but it certainly is supported.  There's
an option to allow for a secondary boot loader, such as FreeBSD's
/boot/loader, to call back into uboot to read things from
flash/disk/whatever, do network access, etc.  Not so much a HAL, but
more of an echo of the functionality provided by PC BIOS functions.
/boot/loader can be viewed as a mini OS that calls back into uboot to
have it do things.  Once /boot/loader loads FreeBSD, btw, it and uboot
disappear from the scene, so this isn't exactly a HAL situation...

Warner


: >
: >> It is not HAL if it can't be called.
: >>
: >>>
: >>>
: >>>> The potential for "vendors breaking out of the debugging use case and
: >>>> turning it into a HAL" is miniscule, because
: >>>>
: >>>> a) The callback is disabled by default
: >>>> b) The technical challenges of the callback interface limit its
: >>>> applicability to specific "wizard user" scenarios
: >>>> c) OFW is unlikely to achieve sufficient market penetration for the
: >>>> HAL thing to be worth doing
: >>>>
: >>>>
: >>>> _______________________________________________
: >>>> linux-arm-kernel mailing list
: >>>> linux-arm-kernel at lists.infradead.org
: >>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
: >>>
: >>>
: >
: >
: _______________________________________________
: devicetree-discuss mailing list
: devicetree-discuss at lists.ozlabs.org
: https://lists.ozlabs.org/listinfo/devicetree-discuss
: 
: 
