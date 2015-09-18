From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 21:53:00 +0200
Subject: [PATCH 2/3] ARM: dts: sun5i: Add sun5i-q8-common.dtsi
In-Reply-To: <55F19C43.2000601@redhat.com>
References: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
 <1441464953-26351-2-git-send-email-hdegoede@redhat.com>
 <20150908143320.GB31584@lukather> <55EF529B.80401@redhat.com>
 <20150909140156.GC9885@lukather> <55F19C43.2000601@redhat.com>
Message-ID: <20150918195300.GX4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 05:05:39PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09-09-15 16:01, Maxime Ripard wrote:
> >On Tue, Sep 08, 2015 at 11:26:51PM +0200, Hans de Goede wrote:
> >>Hi,
> >>
> >>On 09/08/2015 04:33 PM, Maxime Ripard wrote:
> >>>On Sat, Sep 05, 2015 at 04:55:52PM +0200, Hans de Goede wrote:
> >>>>This is the sun5i / a13 version of sun8i-q8-common.dtsi for use in dts
> >>>>files for a13 q8 based tablets. Compared to sun8i this uses uart1 for the
> >>>>serial console, and PG0 for card-detect for mmc0.
> >>>>
> >>>>This also adds pmic and otg support, which both use the same config on
> >>>>all known q8 a13 devices. This is not present in sun5i-q8-common.dtsi
> >>>>because pmic / otg support for sun8i has not yet been merged.
> >>>>
> >>>>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>
> >>>Are we going to have any user but the one you posted in the patch 3
> >>>planned?
> >>
> >>Depends on what I can get my hands on / what is in the post atm.
> >>
> >>One difference in fex files of different 18 variants is how the usb wifi is
> >>powered, either via a gpio or via ldo3. Also there are differences in which
> >>accelerometer is used, so eventually I expect there to be several users
> >>of this dtsi.
> >
> >But no difference in the SoC used (A13 vs A10s)?
> >
> >I'm not sure having 18 DTs for a single board name is going to be
> >really helpful.
> 
> Sorry I meant to write q8 not 18 :)
> 
> >It would be something to be supported by some quirks
> >mechanism, instead of having to require the user to pick the right one.
> 
> Agreed, which is why I added a generic sun5i-a13-q8-tablet.dts, which
> can then later be extended with quirks and such to get all the different
> variants supported. Which I guess means that the contents of
> sun5i-q8-common.dtsi can be folded into sun5i-a13-q8-tablet.dts, otoh
> we may have some special cases which do require a separate dts and
> having sun5i-q8-common.dtsi follows the same scheme as used for the
> a23 / a33 tablets. In the future we should probably also add
> sun8i-a23-q8-tablet.dts and sun8i-a33-q8-tablet.dts files and make
> the existing ones just empty files with a single #include for
> compatibility.
> 
> If possible I would like to at least have you queue up the default
> sun5i-a13-q8-tablet.dts so that we've a dts file for a13 based tablets
> which at least gets the basics going.
> 
> Either in its current form, or with it and sun5i-q8-common.dtsi
> squashed together. If you want a squashed version let me know and
> I'll do a resend.
> 
> Are you coming to ELCE ? I think the both of us should go to:
> 
> http://lceeu2015.sched.org/event/999c45c7fe78824a88269f35539c7e5c#.VfGcCLPYqlM
> 
> (Device Tree NG BoF) and try to hash out a solution for this there,
> the quirks / variants stuff sounds good, but I wonder how far along
> that is ?

I will be to the technical showcase, but we can always discuss with
Pantelis a bit later :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/a4d774dd/attachment.sig>
