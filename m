From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 6 Mar 2015 23:56:06 +0100
Subject: twl4030_charger: need changes to get probed?
In-Reply-To: <20150306224034.GA20559@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com>
 <20150306224034.GA20559@amd>
Message-ID: <201503062356.06110@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 March 2015 23:40:34 Pavel Machek wrote:
> On Sat 2015-03-07 00:12:07, Grazvydas Ignotas wrote:
> > On Fri, Mar 6, 2015 at 11:57 PM, Pali Roh?r
> > <pali.rohar@gmail.com> wrote:
> > > On Friday 06 March 2015 22:24:17 Pavel Machek wrote:
> > >> Hi!
> > >> 
> > >> According to n900 dts, twl4030-bci (aka charger) should
> > >> be included.
> > > 
> > > AFAIK it is not present on n900...
> > 
> > Right, it uses twl5030 variant without the charger, charging
> > on n900 is provided by separate chip and for a good reason
> > as twl's charger is not that good. Forcing the driver to
> > load just ends up with it accessing non-existent registers
> > over i2c.
> 
> Ok, but:
> 
> 1) Why is the twl4030-bci enabled in n900's dts, then
> 

maybe it is bug in n900 dts...

Grazvydas, is there some runtime check if twl4030/twl5030 chip 
has charger or not? or do we need to explicitly disable device 
twl4030-bci in DT?

> and
> 
> 2) When it is enabled, why it does not load?
> 
> (I guess there's no way to get to input voltage on n900...?)
> 
> 									Pavel

you can read voltage only from rx51_battery.ko (TWL ADC) or 
bq27x00_battery.ko

look for Nokia_N900_RX-51_Schematics.pdf file where you can find 
information what is connected to ADC and bq27200 chip.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150306/5841d687/attachment.sig>
