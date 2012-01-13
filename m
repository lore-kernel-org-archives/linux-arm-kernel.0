From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Jan 2012 21:35:54 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <7FE21149F4667147B645348EC605788508FD9C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508E7B0@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1DD6@HQMAIL01.nvidia.com>
 <20120113035506.GB12184@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC605788508FD9C@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20120113133552.GB17029@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 08:07:35AM +0000, Dong Aisheng-B29396 wrote:
> > > But, one thought on doing this in pinmux_get(). I'd simply implement a
> > > Function that read a DT node's pinmux property/node, converted it to a
> > > pinmux mapping table, and registered it with the pinctrl core. Then,
> > > pinmux_get() could simply call this before doing anything else at all.
> > > I don't think you'd need to modify how pinmux_get() worked at all.
> > >
> > This sounds like a pretty good idea to me.
> > 
> This does not fix the inconsistency issue.
> Additionally as I said before, for better support dynamically register pinmux
> Map, it looks we'd better change the pinmux_maps array to a list.
> However this is for dt case.
> But for non-dt case, the static array is just ok.
> So there's conflict.
> Not sure if any better idea to fix this.
> 
My guess is that Linus.W did not get any chance to take the dt case
into account with his first design of pinctrl core.  But I guess he
is open to any reasonable change to pinctrl core for dt adoption.
Linus?

-- 
Regards,
Shawn
