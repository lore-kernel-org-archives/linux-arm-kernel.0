From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Wed, 9 May 2018 21:57:15 +0200
Subject: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
In-Reply-To: <20180508201725.3alpkcpaxebupzqv@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
 <ea34ce99-d446-03d2-b38d-d40a22480337@gmail.com>
 <20180508201725.3alpkcpaxebupzqv@pengutronix.de>
Message-ID: <906d2b27-2e8b-92a9-13ff-2676f48142f4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 05/08/2018 10:17 PM, Uwe Kleine-K?nig wrote:
> Hello Jacek,
> 
> On Tue, May 08, 2018 at 09:33:14PM +0200, Jacek Anaszewski wrote:
>> Thank you for the patch. It looks fine, but please split
>> the drivers/net/can/led.c related changes into a separate one.
> 
> I renamed led_trigger_rename_static() to led_trigger_rename() (and
> changed the parameters). The can change just adapts the only user of
> led_trigger_rename_static() to use the new one.
> 
> It's not impossible to separate this patches, but I wonder if it's worth
> the effort.
> 
> The first patch would be like the patch under discussion, just without
> the can bits and introducing something like:
> 
> 	/*
> 	 * compat stuff to be removed once the only caller is converted
> 	 */
> 	static inline led_trigger_rename_static(const char *name, struct led_trigger *trig)
> 	{
> 		(void)led_trigger_rename(trig, "%s", name);
> 	}
> 
> Then the second patch would just be the 6-line can hunk. And a third
> patch would remove the compat function. (Maybe I'd choose to squash the
> two can patches together then, but this doesn't reduce the overhead
> considerably.) The only upside I can see here is that it increases my
> patch count, but it's otherwise not worth the effort for such an easy
> change. Further more as there is a strict dependency on these three
> patches this either delays the cleanup or (IMHO more likely) the can
> change would go in via the led tree anyhow.  (Mark already acked patch 2
> of this series and in private confirmed that the agrees to let this
> change go in via the led tree, too.)

OK, makes sense. I'll wait also for ack on 3/3 since it should
go through the LED tree as well - uses a new led_trigger_register_format().

-- 
Best regards,
Jacek Anaszewski
