From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Thu, 4 Nov 2010 14:30:14 -0700
Subject: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
References: <1288736227-800-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288736227-800-2-git-send-email-Dinh.Nguyen@freescale.com>
	<4CD12833.8060204@eukrea.com>
	<86A0E76937111F4C92FABEC0A20988510523CEC2@az33exm21>
	<4CD317E2.9090504@eukrea.com>
Message-ID: <86A0E76937111F4C92FABEC0A20988510523CF07@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

>-----Original Message-----
>From: Nguyen Dinh-R00091
>Sent: Thursday, November 04, 2010 4:24 PM
>To: 'Eric B?nard'
>Cc: linux-kernel at vger.kernel.org; amit.kucheria at canonical.com; linux at arm.linux.org.uk;
>s.hauer at pengutronix.de; grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
>daniel at caiaq.de; u.kleine-koenig at pengutronix.de; Zhang Lily-R58066; valentin.longchamp at epfl.ch
>Subject: RE: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
>
>Hi Eric,
>
>>-----Original Message-----
>>From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of
>Eric
>>B?nard
>>Sent: Thursday, November 04, 2010 3:30 PM
>>To: Nguyen Dinh-R00091
>>Cc: linux-kernel at vger.kernel.org; amit.kucheria at canonical.com; linux at arm.linux.org.uk;
>>s.hauer at pengutronix.de; grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
>>daniel at caiaq.de; u.kleine-koenig at pengutronix.de; Zhang Lily-R58066; valentin.longchamp at epfl.ch
>>Subject: Re: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
>>
>>Hi Dinh,
>>
>>Le 04/11/2010 20:21, Nguyen Dinh-R00091 a ?crit :
>>> Reading the ROM code is probably the most reliable way to get the correct
>>> silicon revision. Because the ROM that is on the chip is "most likely"
>>> up-to-date with the silicon. "Most likely" means that 95% of the time, when
>>> you get a new silicon, the ROM code will get updated. There is still a
>>> chance that a new silicon will not require a ROM update.
>>>
>>> Also the other reason is that sometimes the fuses that identify the silicon
>>> revision that are used by the IIM are sometimes not blown to reflect the
>>> correct revision in pre-production parts. MX51 is a post production part,
>>> so in theory, the fuses are blown correctly. But since we made MX51 boards
>>> available prior to going into production, reading from the IIM is not as
>>> reliable as reading the ROM.
>>>
>>Don't you think we should use the documented register which (if we believe the
>>documentation) should be 100% reliable for production CPU instead of this
>>undocumented method which from what you say is 95% reliable and here to handle
>>the case of pre production CPU ?
>>
>>The same problem occured on i.MX35 silicon 2.1 which where not correctly
>>detected using the ROM code.
>>
>
>Would you agree to this approach? Read the IIM register and the ROM code, if the IIM and ROM agree,
>then no issue. But if ROM and IIM disagree, we would go with whatever is the latest Revision?

Nevermind on this. I just got an answer that the IIM register is guaranteed to be a correct silicon revision and no fuses need to be blown. I'll send out a patch for this soon.

Thanks,

Dinh
>
>>Eric
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo at vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
