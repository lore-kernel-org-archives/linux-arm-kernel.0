From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 11 Jun 2018 20:03:59 +0200
Subject: [PATCH v1] ARM: imx: add imx7d-m4
In-Reply-To: <610391dc49d481debe1c71bd3070c73b@agner.ch>
References: <20180405115134.8036-1-o.rempel@pengutronix.de>
 <93e7b7ef-1bc0-2871-da2c-65ab3f070c07@pengutronix.de>
 <20180611082022.GG16091@dragon>
 <1528706126.2842.1.camel@pengutronix.de>
 <3fa291a7da6978545cd21fdcf78c483e@agner.ch>
 <a4657c84-a807-d194-950c-38f5f8e4a53c@pengutronix.de>
 <610391dc49d481debe1c71bd3070c73b@agner.ch>
Message-ID: <20180611180359.ol2piijboqdp753p@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2018 at 02:41:29PM +0200, Stefan Agner wrote:
> On 11.06.2018 13:53, Oleksij Rempel wrote:
> > On 11.06.2018 13:48, Stefan Agner wrote:
> >> On 11.06.2018 10:35, Lucas Stach wrote:
> >>> Hi Shawn,
> >>>
> >>> Am Montag, den 11.06.2018, 16:20 +0800 schrieb Shawn Guo:
> >>>> On Mon, Jun 11, 2018 at 10:02:53AM +0200, Oleksij Rempel wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> this patch was send 05.04.2018. Any comments?
> >>>>>
> >>>>> @Shawn, can you please take it?
> >>>>
> >>>> Honestly I'm not sure how useful it will be.??If we can have some i.MX
> >>>> developers ACK on it, I will be more comfortable to take it.
> >>>
> >>> This is all highly experimental and in PoC stage, but we see some value
> >>> in running a second Linux system on the M4 coprocessor. There are lots
> >>> of things that still need to be figured out, but we are working on this
> >>> from time to time when there are some hours to spare.
> >>>
> >>> This patch seems like a good step in the right direction and IMHO the
> >>> amount of code and changes is small enough to carry it upstream without
> >>> impacting anything else. I would be happy if this could be pulled in.
> >>
> >> I agree with Lucas here, this is rather minimal and not invasive.
> >>
> >>
> >> Out of interest, on what memory region do you run Linux? Do you use
> >> caches? In some experiments a while ago I noticed that only 2MiB/(or
> >> 4MiB) of DDR memory can use caches, which is somewhat tight to run Linux
> >> on.
> >>
> >> https://blog.printk.io/2017/05/i-mx-7-cortex-m4-memory-locations-and-performance/
> > 
> > here is DT part for master system on Cortex A7 to run Linux on Cortex M4:
> > 
> >         memory {
> >                 device_type = "memory";
> >                 reg = <0x80000000 0x40000000>;
> >         };
> > 
> >         reserved-memory {
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 ranges;
> > 
> >                 m4_reserved_sysmem1: rproc at 88000000 {
> >                         reg = <0x88000000 0x4000000>;
> >                         no-map;
> >                 };
> 
> So I guess that is where Linux on the M4 goes? Afaik this is in the
> uncacheable area, so it is rather slow?

I didn't made any performance optimization or comparison.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180611/ccc21651/attachment.sig>
