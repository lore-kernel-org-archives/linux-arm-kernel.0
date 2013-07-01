From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 01 Jul 2013 18:08:10 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gQVJNOiBkdHM6IGkuTVgyNzogQWRkIFNlY29uZGFy?=
 =?UTF-8?B?eSBBSEIgUG9ydCBkZWZpbml0aW9ucw==?=
In-Reply-To: <20130701125819.GJ13206@S2101-09.ap.freescale.net>
References: <1372487325-14405-1-git-send-email-shc_work@mail.ru>
 <20130701125819.GJ13206@S2101-09.ap.freescale.net>
Message-ID: <1372687690.31793480@f308.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Jun 29, 2013 at 10:28:45AM +0400, Alexander Shiyan wrote:
> > Patch adds Secondary AHB Port definitions for i.MX27 SOC and
> > moves NAND Flash Controller (NFC) under AHB Slave Port 1.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/boot/dts/imx27.dtsi | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> > index 86b6f5f..7c0179e 100644
> > --- a/arch/arm/boot/dts/imx27.dtsi
> > +++ b/arch/arm/boot/dts/imx27.dtsi
> > @@ -399,14 +399,30 @@
> >  			};
> >  		};
> >  
> > -		nfc: nand at d8000000 {
> > +		ahb1: ahb at 80000000 { /* Secondary AHB Slave Port 1 */
> 
> We do not have the top level of AHB bus topology represented in device
> tree.  Your patch introduces it, partially - all about Secondary AHB
> Slave but nothing about Primary AHB.
> 
> I'm not really fond of the change, since it's not extremely useful to
> me.  Do you have a real reason for the change?

Introducing primary bus will produce a completely different i.MX27 DTS,
since it contain AIPI1,2 and iram.
Introduction of buses has no effect, other than the possibility of using labels
and minimal validation of nodes to the correct address.
In this case, I define the bus here for the subsequent addition of WEIM,
for a better understanding of what and where is.
Of course we can do without it. Think is it unnecessary?
Thanks.

---
