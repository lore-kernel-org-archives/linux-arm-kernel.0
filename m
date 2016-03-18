From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 18 Mar 2016 14:15:39 +0000
Subject: [PATCH 1/2] arm64: dts: juno/vexpress: fix node name
 unit-address presence warnings
In-Reply-To: <CAL_JsqJEA9rVOzD=wC8TJnzm+ou=mnRLrkNU2zgrH402=pm3Tw@mail.gmail.com>
References: <1457352735-24453-1-git-send-email-sudeep.holla@arm.com>
 <CAL_JsqJeeZ58at95gSRwOMnce_DjDsXVRYH_bMKaX=uDHtZAAA@mail.gmail.com>
 <1458297136.2812.7.camel@linaro.org>
 <CAL_JsqJEA9rVOzD=wC8TJnzm+ou=mnRLrkNU2zgrH402=pm3Tw@mail.gmail.com>
Message-ID: <1458310539.2812.16.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-03-18 at 08:09 -0500, Rob Herring wrote:
> On Fri, Mar 18, 2016 at 5:32 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> > On Thu, 2016-03-17 at 16:44 -0500, Rob Herring wrote:
> >> On Mon, Mar 7, 2016 at 6:12 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
[...]
> >> > Let me know.
> >> >
> >> > Regards,
> >> > Sudeep
> >> >
> >> > diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> >> > index 9314f3943269..ba03c934a861 100644
> >> > --- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> >> > +++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> >> > @@ -89,7 +89,7 @@
> >> >                              <0 63 4>;
> >> >         };
> >> >
> >> > -       smb {
> >> > +       smb at 0,08000000 {
> >>
> >> Drop the comma and leading zeros. Comma is for distinct fields like
> >> bus,dev,func on PCI.
> >
> > So what is the correct way of representing 2 cell addresses? Not just
> > those that are logically 64-bit addresses, (which I guess could be just
> > a single number), but things like vexpress motherboard where we have
> > Chip-select and Offset values?
> 
> 64-bit address is just a single number.
> 2 cells with distinct fields should generally be ...@<cell1>,<cell2>
> 
> If you have your own bus type, you can devise whatever you like as
> long as it is reviewed.
> 
> > I looked at ePAPR but it just says 'The unit-address must
> > match the first address specified in the reg property of the node.' and
> > lists valid characters for unit address, which includes ,._+-
> 
> Yes, we need to clarify this some.

Yes, because there is already quite a bit of use of @X,Y for two cell
64-bit addresses (Tegra mostly, I assume they're 64-bit addresses).

And for 32-bit addresses lots of use of leading zeros to pad address to
consistence number of digits, both in unit names and in reg properties.

$ grep '@0[^ ^,]' -R arch/arm/boot/dts | wc -l
1300

-- 
Tixy
