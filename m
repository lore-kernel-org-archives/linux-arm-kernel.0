From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 04 Jul 2017 21:37:48 +0200
Subject: [PATCH v3 02/12] ALSA: ac97: add an ac97 bus
In-Reply-To: <s5hpodhc28v.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon,
 03 Jul 2017 11:13:04 +0200")
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-3-robert.jarzmik@free.fr>
 <s5hpodhc28v.wl-tiwai@suse.de>
Message-ID: <87bmp0t2lv.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Takashi Iwai <tiwai@suse.de> writes:

> On Fri, 30 Jun 2017 21:43:58 +0200,
> Robert Jarzmik wrote:
>> +static struct bus_type ac97_bus_type = {
>> +	.name		= "ac97",
>
> Name-conflict with the old ac97 bus?
Yeah, fair point. So what should I choose for this new one ?
 - ac97new
 - ac97bis
 - ac97_2
 - ac97reborn

>> +static int __init ac97_bus_init(void)
>> +{
>> +	return bus_register(&ac97_bus_type);
>> +}
>> +subsys_initcall(ac97_bus_init);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
>
> No bus_unregister() at exit?
Mmmh, that's because I used subsys_initcall(), which doesn't look good in a
module compilation setup. That will require a module_init(), and I will think
about how to implement it and test it for next iteration.

Cheers.

-- 
Robert
