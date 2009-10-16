From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 16 Oct 2009 11:02:58 +0200
Subject: [RFC] mx31moboard: patches for next merge window
In-Reply-To: <20091016081722.GB7208@pengutronix.de>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
	<20091016081722.GB7208@pengutronix.de>
Message-ID: <4AD836C2.7070707@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> On Thu, Oct 15, 2009 at 11:42:54AM +0200, Valentin Longchamp wrote:
>> Here are the patches I would like to push during the next merge window for
>> the mx31moboard platform.
>>
>> It consists of a fix for a small hardware design issue for the main serial
>> port, a few GPIOs used on the robots that are declared, camera support and
>> finally MC13783 support as it is now getting ready.
>>
>> For MC13783, we would need RTC as well, but I did not add it yet since it
>> is not in mainline yet.
> Note I'm currently overhauling mc13783-core.c resulting in an API change.
> 
> I plan to add some compatibility stuff, but I'll let you know when I'm
> done anyhow.  Are you interested in testing my changes?

Sure. Tell me when you have something and I will give them a spin on the 
robot.

> 
> I don't know yet if I will try to get the rtc-support into mainline, but
> Sasche posted a patch (without feedback) some time ago.  (It's only a
> minimal driver, no alarm, no reset detection.)
> 

That would be nice. We only rely on this MC13783 RTC, so if we can get 
it into mainline it would be great for us.

Another thing is the RGB led support. We have two of these leds on our 
robot. Is anyone else using them ? Has someone already worked on them ? 
The support should not be very hard to add now that we have MC13783 core 
support and since there is a LED class. The only API change to led would 
be to add RGB support, which is not present now. Any comments on this ?

Best Regards

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
