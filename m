From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 5 Feb 2016 19:28:45 +0100
Subject: [PATCH v3 3/3] reset: Add support for shared reset controls
In-Reply-To: <1454663304.6406.3.camel@pengutronix.de>
References: <1453918516-3078-1-git-send-email-hdegoede@redhat.com>
 <1453918516-3078-4-git-send-email-hdegoede@redhat.com>
 <1454663304.6406.3.camel@pengutronix.de>
Message-ID: <56B4E9DD.3060000@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05-02-16 10:08, Philipp Zabel wrote:
> Am Mittwoch, den 27.01.2016, 19:15 +0100 schrieb Hans de Goede:
> [...]
>> @@ -94,9 +99,16 @@ EXPORT_SYMBOL_GPL(reset_controller_unregister);
>>   /**
>>    * reset_control_reset - reset the controlled device
>>    * @rstc: reset controller
>> + *
>> + * Calling this on a shared reset controller is an error.
>>    */
>>   int reset_control_reset(struct reset_control *rstc)
>>   {
>> +	if (rstc->shared) {
>> +		WARN_ON(1);
>> +		return -EINVAL;
>
> Occurrences of
> 	if (condition) {
> 		WARN_ON(1);
> 		...
> 	}
> could be changed to
> 	if (WARN_ON(condition)) {
> 		...
> 	}

Good one, will fix for v4 (v2 of the second attempt at this).

Regards,

Hans
