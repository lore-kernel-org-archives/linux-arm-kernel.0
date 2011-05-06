From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Fri, 06 May 2011 14:43:49 +0100
Subject: [RFC] What is the preferred way to share ADC unit between hwmon
	and input(ts) drivers?
In-Reply-To: <20110425110230.GD4768@sirena.org.uk>
References: <4DB4C252.30005@emcraft.com> <20110425110230.GD4768@sirena.org.uk>
Message-ID: <4DC3FB15.5090307@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/11 12:02, Mark Brown wrote:
> On Mon, Apr 25, 2011 at 04:37:38AM +0400, Ilya Yanok wrote:
> 
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
IIO is fine for the adc side if it is general purpose (and typically
used as such). If it's typically used for power supply monitoring then
hwmon is the right place.

The touch screen element should definitely be in input though so
you will need a solution to the problem of shared registers.
