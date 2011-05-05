From: yanok@emcraft.com (Ilya Yanok)
Date: Fri, 06 May 2011 03:43:37 +0400
Subject: [RFC] What is the preferred way to share ADC unit between	hwmon
	and input(ts) drivers?
In-Reply-To: <20110425110230.GD4768@sirena.org.uk>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
Message-ID: <4DC33629.6040405@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 25.04.2011 15:02, Mark Brown wrote:
>> So, to add both input and hwmon drivers we need to serialize the
>> register accesses. I was thinking about adding some middle-layer to
>> perform the actual conversion. The question is what is the preferred way
>> to add such a middle layer? Should we use a multi-function device driver
>> for this or just some platform-specific code (as S3C does)? Or maybe
>> there is another way?
> 
> IIO would probably be the standard API to use but that's still stuck in
> staging.  I'd suggest doing a custom API and then transitioning to IIO
> when that moves out of staging.

Thanks for the pointer. Yes, I think we'll do as you advised.

Thanks!

Regards, Ilya.
