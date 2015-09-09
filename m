From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Sep 2015 16:01:56 +0200
Subject: [PATCH 2/3] ARM: dts: sun5i: Add sun5i-q8-common.dtsi
In-Reply-To: <55EF529B.80401@redhat.com>
References: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
 <1441464953-26351-2-git-send-email-hdegoede@redhat.com>
 <20150908143320.GB31584@lukather> <55EF529B.80401@redhat.com>
Message-ID: <20150909140156.GC9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 11:26:51PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09/08/2015 04:33 PM, Maxime Ripard wrote:
> >On Sat, Sep 05, 2015 at 04:55:52PM +0200, Hans de Goede wrote:
> >>This is the sun5i / a13 version of sun8i-q8-common.dtsi for use in dts
> >>files for a13 q8 based tablets. Compared to sun8i this uses uart1 for the
> >>serial console, and PG0 for card-detect for mmc0.
> >>
> >>This also adds pmic and otg support, which both use the same config on
> >>all known q8 a13 devices. This is not present in sun5i-q8-common.dtsi
> >>because pmic / otg support for sun8i has not yet been merged.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> >Are we going to have any user but the one you posted in the patch 3
> >planned?
> 
> Depends on what I can get my hands on / what is in the post atm.
> 
> One difference in fex files of different 18 variants is how the usb wifi is
> powered, either via a gpio or via ldo3. Also there are differences in which
> accelerometer is used, so eventually I expect there to be several users
> of this dtsi.

But no difference in the SoC used (A13 vs A10s)?

I'm not sure having 18 DTs for a single board name is going to be
really helpful. It would be something to be supported by some quirks
mechanism, instead of having to require the user to pick the right one.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150909/fcab38ee/attachment.sig>
