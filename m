From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 06 Nov 2014 23:46:21 +0100
Subject: [PATCHv0 2/3] rtc: rtc-isl12057: fix isil vs isl naming for
 intersil
References: <cover.1415222752.git.arno@natisbad.org>
 <2ac5b475fd757ea771296ea0731de75d963999ef.1415222752.git.arno@natisbad.org>
 <20141106053253.GK8509@sirena.org.uk>
Message-ID: <874mucne0y.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Mark Brown <broonie@kernel.org> writes:

> On Wed, Nov 05, 2014 at 10:42:41PM +0100, Arnaud Ebalard wrote:
>
>> When Intersil ISL12057 driver was introduced by commit 70e123373c05
>> (rtc: Add support for Intersil ISL12057 I2C RTC chip), the vendor
>> prefix 'isl' was used instead of the expected 'isil' (Intersil
>> NASDAQ symbol). Recently, a patch from Philip Zabel (7a6540ca856a,
>> ARM: mvebu: Change vendor prefix for Intersil Corporation to isil)
>> fixed that prefix in ReadyNAS devices .dts files (AFAICT, the only
>> kernel users at the moment).
>
> They may be the only in kernel users but someone with an out of tree DT
> may be using the existing prefix, we shouldn't break compatibility with
> them so we should support both compatible strings even if we want to
> deprecate the isl, one.

Updating the patch in the following way should make it possible to
support out-of-tree users while avoiding additional uses of 'isl': 

- have two compatible entries in isl12057_dt_match struct instead of one
  i.e.:

    static const struct of_device_id isl12057_dt_match[] = {
   	{ .compatible = "isl,isl12057" },
   	{ .compatible = "isil,isl12057" },
    	{ },
    };

  I think it matches the situation we have.

- keeping the updates I had for trivial-devices.txt and
  vendor-prefixes.txt files.

Thoughts?

Cheers,

a+
