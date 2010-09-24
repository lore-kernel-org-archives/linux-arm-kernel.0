From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 24 Sep 2010 12:07:19 -0700
Subject: [PATCH v7 4/6] OMAP4: hwmod data: Add watchdog timer
In-Reply-To: <4C992FEF.60106@ti.com> (Benoit Cousson's message of "Wed, 22 Sep
	2010 00:21:35 +0200")
References: <1285076228-24736-1-git-send-email-charu@ti.com>
	<1285076228-24736-5-git-send-email-charu@ti.com>
	<4C992FEF.60106@ti.com>
Message-ID: <87fwwzarko.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 9/21/2010 3:37 PM, Varadarajan, Charulatha wrote:

[...]

>>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>>   	/* dmm class */
>>   	&omap44xx_dmm_hwmod,
>> @@ -472,6 +602,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>>
>>   	/* mpu class */
>>   	&omap44xx_mpu_hwmod,
>> +	/* wd_timer class */
>> +	&omap44xx_wd_timer2_hwmod,
>> +
>> +	/* wd_timer3 not yet supported */
>> +/*	&omap44xx_wd_timer3_hwmod, */
>
> Sorry, I forgot to comment that part in your previous revision.
> What we agreed with Kevin is to enable that hwmod watchdog as well in
> order to allow the hwmod core to initialize properly this module, even
> if it not used by any driver yet.
>
> Beside that you can add my Acked-by: for the whole series.

Charu,

If this is OK with you, can you test with timer3 hwmod enabled, and
repost an updated version of this patch?

Then, I will add Benoit's ack and queue this up for 2.6.37.

Kevin
