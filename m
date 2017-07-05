From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 05 Jul 2017 22:21:39 +0200
Subject: [PATCH v3 02/12] ALSA: ac97: add an ac97 bus
In-Reply-To: <s5hbmp0c6a3.wl-tiwai@suse.de> (Takashi Iwai's message of "Tue,
 04 Jul 2017 22:10:28 +0200")
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-3-robert.jarzmik@free.fr>
 <s5hpodhc28v.wl-tiwai@suse.de> <87bmp0t2lv.fsf@belgarion.home>
 <s5hbmp0c6a3.wl-tiwai@suse.de>
Message-ID: <877ezmtz1o.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Takashi Iwai <tiwai@suse.de> writes:

> On Tue, 04 Jul 2017 21:37:48 +0200,
> Robert Jarzmik wrote:
>> 
>> Takashi Iwai <tiwai@suse.de> writes:
>> 
>> > On Fri, 30 Jun 2017 21:43:58 +0200,
>> > Robert Jarzmik wrote:
>> >> +static struct bus_type ac97_bus_type = {
>> >> +	.name		= "ac97",
>> >
>> > Name-conflict with the old ac97 bus?
>> Yeah, fair point. So what should I choose for this new one ?
>>  - ac97new
>>  - ac97bis
>>  - ac97_2
>>  - ac97reborn
>
> ac97bus
> ac97_episode_5
> ac98
> ...
>
> I have no opinion on it.
Ah clone wars one is really tempting :)
But let's have ac97bus actually.

> You can use subsys_init() for modules, it's no problem.
> When it's built for a module, all xxx_init() is handled as equivalent
> with module_init().  See linux/module.h.
>
> It's just the lack of module_exit() in your case.
Got it, I'll add it for v4.

Cheers.

-- 
Robert
