From: yanok@emcraft.com (Ilya Yanok)
Date: Fri, 06 May 2011 03:41:29 +0400
Subject: [RFC] What is the preferred way to share ADC unit between hwmon
	and input(ts) drivers?
In-Reply-To: <20110425052512.GB484@kurt.e-circ.dyndns.org>
References: <4DB4C252.30005@emcraft.com>
	<20110425052512.GB484@kurt.e-circ.dyndns.org>
Message-ID: <4DC335A9.6000709@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kurt,

On 25.04.2011 09:25, Kurt Van Dijck wrote:
>> So, to add both input and hwmon drivers we need to serialize the
>> register accesses.
> 
> 1 physical device may contain several 'class_device's, even if they're of
> different types.  So in a single platform_device probe function, you can do
> both 'input_register_device' and 'hwmon_register_device'.
> This way of working actually puts 2 drivers in 1 file, and let those
> share 1 lock (mutex or so). A peripheral with 2 functions mixed together
> should IMHO be addressed this way. Your driver is the coupling
> between hardware (mixed functions) and Linux device model (clean seperation).

Yes, I know this is possible. Still, I think it's not desired. I should
ask my customer...
My concern is pushing these changes upstream. Is such two-in-one driver
going to be easily accepted?

Anyway, thanks for the idea.

>> I was thinking about adding some middle-layer to
>> perform the actual conversion. The question is what is the preferred way
>> to add such a middle layer?
> 
> IMHO a middle layer for this type of problem is a bit overkill.

Still I can see that at least S3C does this.

>> Should we use a multi-function device driver
>> for this or just some platform-specific code (as S3C does)? Or maybe
>> there is another way?
> 
> AFAIK MFD is a solution when multiple devices have sequential register maps.
> MFD does no locking.

Well, yes. MFD was just another idea where to put custom API piece...

Thanks!

Regards, Ilya.
