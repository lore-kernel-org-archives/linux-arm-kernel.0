From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Mon, 12 Apr 2010 21:29:28 +0200
Subject: [PATCH] Arm nomadik : Vendor tool compatibility
In-Reply-To: <x2y63386a3d1003311634l71486234n95f60e506b776948@mail.gmail.com>
References: <577FAEEB8540FB4F9C91B6BB262576755905DC@XVS-DCFR-22.europe.corp.altran.com>
	<x2y63386a3d1003311634l71486234n95f60e506b776948@mail.gmail.com>
Message-ID: <y2l8cad0aa1004121229o894a17f0w9045882c214bd090@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

2010/4/1 Linus Walleij <linus.ml.walleij@gmail.com>

> 2010/3/31 Lemetayer Jean Marie <jeanmarie.lemetayer@altran.com>:
>
> > +#ifdef CONFIG_VENDOR_TOOL_COMPATIBILITY
> > +static struct nand_ecclayout nomadik_ecc_layout = {
> > +       .eccbytes = 3 * 4,
> > +       .eccpos = {
> > +               0x28, 0x29, 0x2A,
> > +               0x2B, 0x2C, 0x2D,
> > +               0x2E, 0x2F, 0x30,
> > +               0x31, 0x32, 0x33},
> > +       .oobfree = {{0x02, 0x26}, {0x34, 0x0C} },
> > +};
> > +#else
> >  static struct nand_ecclayout nomadik_ecc_layout = {
> >         .eccbytes = 3 * 4,
> >         .eccpos = { /* each subpage has 16 bytes: pos 2,3,4 hosts ECC */
> > @@ -54,6 +65,7 @@ static struct nand_ecclayout nomadik_ecc_layout = {
> >         /* let's keep bytes 5,6,7 for us, just in case we change ECC algo
> */
> >         .oobfree = { {0x08, 0x08}, {0x18, 0x08}, {0x28, 0x08}, {0x38,
> 0x08}
> > },
> >  };
> > +#endif
>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>
> I don't think any of this layout belongs in the driver itself frankly
> speaking,
> I am facing the need to use this in U300 and we use yet *another*
> ECC layout with the FSMC, so we have to add yet another #ifdef.
> However I can fix that up with a patch on top of this one after it's
> queued.
>
> Yours,
> Linus Walleij
>

What king of modification would you do ?
Do you think it shall be queued before your submission ?

Regards,
JM
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100412/d06c9e57/attachment-0001.htm>
