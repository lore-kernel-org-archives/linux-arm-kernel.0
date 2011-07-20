From: vapier.adi@gmail.com (Mike Frysinger)
Date: Wed, 20 Jul 2011 01:38:07 -0400
Subject: [PATCH v2] mtd: dataflash: add device tree probe support
In-Reply-To: <1311139971.20738.154.camel@sauron>
References: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
	<1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
	<20110715025407.GF2927@ponder.secretlab.ca>
	<20110715044919.GB1840@S2100-06.ap.freescale.net>
	<1311136844.20738.131.camel@sauron>
	<20110720045547.GA5766@S2100-06.ap.freescale.net>
	<1311139071.20738.147.camel@sauron>
	<20110720052824.GB5766@S2100-06.ap.freescale.net>
	<1311139971.20738.154.camel@sauron>
Message-ID: <CAMjpGUdW=uW4aDQ0BD1VW-7Vc9KXuOXR50+Nbrd3VUyy_P64TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 01:32, Artem Bityutskiy wrote:
> On Wed, 2011-07-20 at 13:28 +0800, Shawn Guo wrote:
>> On Wed, Jul 20, 2011 at 08:17:45AM +0300, Artem Bityutskiy wrote:
>> > On Wed, 2011-07-20 at 12:55 +0800, Shawn Guo wrote:
>> > > On Wed, Jul 20, 2011 at 07:40:38AM +0300, Artem Bityutskiy wrote:
>> > > > On Fri, 2011-07-15 at 12:49 +0800, Shawn Guo wrote:
>> > > > > > > +static const struct of_device_id dataflash_dt_ids[] = {
>> > > > > > > + { .compatible = "atmel,at45xxx", },
>> > > > > > > + { .compatible = "atmel,dataflash", },
>> > > > > > > + { /* sentinel */ }
>> > > > > > > +};
>> > > > > > > +
>> > > > > >
>> > > > > > This should be protected with a #ifdef CONFIG_OF/#else/#endif, and
>> > > > > > there should be a MODULE_DEVICE_TABLE().
>> > > > > >
>> > > > > I personally hate #ifdef stuff. ?But okay, I can do it since there
>> > > > > are people being concerned by this little waste of space.
>> > > >
>> > > > I guess the question is - will it compile and work if CONFIG_OF is
>> > > > unset?
>> > > >
>> > > Yes, it will compile, as 'struct of_device_id' is defined in
>> > > include/linux/mod_devicetable.h unconditionally.
>> >
>> > And it will work correctly even though dataflash_dt_ids is not NULL, it
>> > will not confuse MTD layer?
>> >
>> I think for non-dt case, dataflash_dt_ids is not used anyway. ?So yes,
>> it will not confuse MTD layer, at least from my testing.
>
> And it is not error-prone? I mean, it is not very likely that someone
> changing MTD could make wrong assumptions and break dataflash driver? If
> so, then we probably do not need ifdefs indeed.

except for the part where device tree code shouldnt be wasting space
on non-device tree systems
-mike
