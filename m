From: csd@broadcom.com (Christian Daudt)
Date: Mon, 11 Feb 2013 19:25:34 -0800
Subject: [PATCH V4] ARM: bcm281xx: Add timer driver
In-Reply-To: <5119B041.9040007@wwwdotorg.org>
References: <1360626279-26701-1-git-send-email-csd@broadcom.com>
 <5119B041.9040007@wwwdotorg.org>
Message-ID: <5119B62E.9020901@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-02-11 07:00 PM, Stephen Warren wrote:
> On 02/11/2013 04:44 PM, Christian Daudt wrote:
>> This adds support for the Broadcom timer, used in the following SoCs:
>> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
>> +static const struct of_device_id bcm_timer_ids[] __initconst = {
>> +	{.compatible = "bcm,kona-timer"},
>> +	{},
>> +};
>> +
>> +static void __init kona_timers_init(void)
>> +{
>> +	struct device_node *node;
>> +	u32 freq;
>> +
>> +	node = of_find_matching_node(NULL, bcm_timer_ids);
>> +
>> +	if (!node)
>> +		panic("No timer");
> I assume this is for 3.10 now.
Oh. I missed 3.9 window ? Got busy with other stuff. Oh well, try again.
> Can you rework this to remove
> bcm_timer_ids[] and that of_find_matching_node() call, and replace it
> with e.g.:
>
> CLOCKSOURCE_OF_DECLARE(kona, "bcm,kona-timer", kona_timer_init);
where can I find an example ? I looked throught armsoc/for-next and the 
code there has CLOCKSOURCE_OF_DECLARE but it still has 
of_find_matching_node calls in the init fns - is it still in the process 
of being removed ?

  Thanks,
    csd
