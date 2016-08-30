From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Aug 2016 18:33:05 +0200
Subject: [PATCH 4/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-gt90h
In-Reply-To: <913fab6d-a5a9-fe3f-80bd-f52b70974300@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
 <20160822183009.GX7104@lukather>
 <cf0186a0-f4ea-173c-4f93-df8798941199@redhat.com>
 <20160823092614.GF2598@lukather>
 <a8de228d-2ba9-e23e-0c0c-e9a78dbe6e6a@redhat.com>
 <20160823151738.GM2598@lukather>
 <8541f3c3-c83b-bd20-42cf-03fdfb3a33d9@redhat.com>
 <20160826204637.GC3165@lukather>
 <913fab6d-a5a9-fe3f-80bd-f52b70974300@redhat.com>
Message-ID: <20160830163305.GH18605@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2016 at 10:32:16AM +0200, Hans de Goede wrote:
> >>a13-94v-0:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600 inverted-x
> >>a13-tzx-713b-v2.1:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600
> >>a23-q8h-v3:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
> >>a23-tj-a23-q88-v4.0:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600
> >>a23-tw-ao721-v41:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600 inverted-x
> >>a23-ippo-q8h-v1.2:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
> >>a33-ippo-q8h-v1.2:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
> >>a33-tzx-723q4:		b482 a33-Q8_V2.4_1118/GSL1680_FW_D702.fw		 960x640 inverted-x
> >>a33-q8-v2.4-1118:	b482 a33-Q8_V2.4_1118/GSL1680_FW_D702.fw		 960x640
> >>a33-q8h-v1.5:		b482 a33-q8h-v1.5/GSL1688_A70_FW.fw			 960x640
> >>
> >>I'm working on a q8hardware-mgr (inspired by the beagle bone cape mgr)
> >>to automatically detect the touchscreen controller as well as the controller id
> >>(the 2nd column above), and it will need to set a filename for the firmware
> >>file based on this, deriving this from the machine compatible will
> >>simply not work here.
> >
> >I'm not sure why we need to stick to some insane naming scheme. Or why
> >can't we use symlinks.
> 
> All the above tablets use the same dts file (sun5i-a13-q8-tablet.dts,
> sun8i-a23-q8-tablet.dts, sun8i-a33-q8-tablet.dts) while not having
> the same touchscreen, as discussed in the past I'm working on a kernel
> module to detect which touchscreen is in use and then automatically
> update the dt using dynamic-devicetree since creating a separate dt
> file for each variant is madness (there is a new revision every few
> weeks).
> 
> I already have this sort of working and I can detect if a tablet has
> a gsl1680 touchscreen (*) and if it is the a082 or b482 variant. Now
> we could encode the chip-id (the a082/b482) in the firmware name
> at the driver level, but that is still not good enough, e.g. these
> 2 tablets:
> 
> a23-q8h-v3:		a082 a23-tj-a23-q88-v4.0_20140815/GSL1688_A70_FW.fw	 800x480 swapped-x-y
> a23-tj-a23-q88-v4.0:	a082 a23-tj-a23-q88-v4.0_20140815/GSL1680E_700_FW.fw	1024x600
> 
> Both use a a082 revision gsl1680 but need different firmware files,
> since they both use sun8i-a23-q8-tablet.dts, so simply embedding
> the machine compatible string in the filename passed to
> request_firmware is not going to help.
> 
> I hope to get permission to get these firmware files added to
> linux-firmware and then the different files need unique names,
> and we need a way to specify in devicetree which file to load.
> 
> We can do some weird indirect dance but that is not really
> helpful, esp. since I also expect users to need to override
> which firmware file gets used in certain cases and in that
> scenario simply specifying the filename certainly is the most
> userfriendly.
> 
> TL;DR: we need a way to specify which firmware needs to
> be loaded and this CANNOT be derived from the machine
> compatible as devices with the same machine compatible
> need different firmwares.

You convinced me. Let's see Rob's answer, on your new serie, but since
it's what he suggested, that should be ok.

I'll merge it as soon as he's ok with it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160830/c4eace1c/attachment.sig>
