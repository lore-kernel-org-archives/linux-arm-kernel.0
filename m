From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 18:47:13 +0200
Subject: [linux-sunxi] Re: [PATCH 2/6] ARM: dts: sun7i: Enable USB DRC on
 Bananapi
In-Reply-To: <56162B53.8020800@redhat.com>
References: <1442928966-6418-1-git-send-email-hdegoede@redhat.com>
 <1442928966-6418-2-git-send-email-hdegoede@redhat.com>
 <20150929080453.GN7104@lukather> <560A4B3D.4040007@redhat.com>
 <20151001083242.GB7104@lukather> <56162B53.8020800@redhat.com>
Message-ID: <20151011164713.GO2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 09:37:39AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 10/01/2015 09:32 AM, Maxime Ripard wrote:
> >Hi,
> >
> >On Tue, Sep 29, 2015 at 10:26:37AM +0200, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 29-09-15 10:04, Maxime Ripard wrote:
> >>>On Tue, Sep 22, 2015 at 03:36:01PM +0200, Hans de Goede wrote:
> >>>>Enable the otg/drc usb controller on the Bananapi.
> >>>>
> >>>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>
> >>>Applied all the other patches but this one.
> >>
> >>Thanks, seems you did not push this to your git.kernel.org repo though ?
> >
> >I think I did, but maybe not at the time you sent the mail.
> >
> >>>Since we dropped the patch adding the regulators support on the
> >>>Bananapi until we figure out why the board crash, it doesn't compile
> >>>anymore.
> >>
> >>How about me doing a v2 of the regulators patch which removes the
> >>
> >>&cpu0 {
> >>         cpu-supply = <&reg_dcdc2>;
> >>};
> >>
> >>So that we do not get cpu voltage scaling, then the regulator
> >>changes should be a NOP, everything should just keep the u-boot
> >>set voltages, and we can enable oth support.
> >>
> >>And then when we've figured out a safe way to enable cpu voltage
> >>scaling we can do so with a follow up patch ?
> >>
> >>Is that a plan ? If so say yes and I'll do a v2 of these patches :)
> >
> >Yep, it sounds like a good plan :)
> 
> With the new v3 of the regulators patch with the corrected opp-s which
> was just send this should no longer be necessary, can you apply the
> original "ARM: dts: sun7i: Enable USB DRC on Bananapi" after applying
> v3 of the regulators patch please ?

Sure, I just did it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/72f8cd2d/attachment.sig>
