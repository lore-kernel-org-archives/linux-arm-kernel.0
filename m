From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Jan 2012 22:23:22 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <4F10362D.3020507@stericsson.com>
References: <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508E7B0@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1DD6@HQMAIL01.nvidia.com>
 <20120113035506.GB12184@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC605788508FD9C@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120113133552.GB17029@S2101-09.ap.freescale.net>
 <4F10362D.3020507@stericsson.com>
Message-ID: <20120113142319.GA1810@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 02:48:29PM +0100, Linus Walleij wrote:
> On 01/13/2012 02:35 PM, Shawn Guo wrote:
> >My guess is that Linus.W did not get any chance to take the dt case
> >into account with his first design of pinctrl core.  But I guess he
> >is open to any reasonable change to pinctrl core for dt adoption.
> >Linus?
> 
> Any patches welcome.
> 
> However we cannot *require* DT for pinctrl to work, there
> are archs that do not use DT and these must also be able
> to use pinctrl. For example arch/blackfin have expressed
> interest IIRC.
> 
Definitely.

> Then the question of whether to also support mixed configs
> where some callers get data from DT and some from
> platform data. I suspect that this is necessary for the
> single kernel goal.
> 
Yes.  Right now, imx3, imx5 and imx6 have supported single kernel
image.  We probably can not convert these three platforms all over
to pinctrl subsystem at one time.  So we definitely need that
support to make the conversion/merge them one by one possible.

-- 
Regards,
Shawn
