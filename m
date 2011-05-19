From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 19 May 2011 11:34:03 +0200
Subject: [patch 0/7] clocksources/clockevents improvements
In-Reply-To: <20110518205713.947614271@linutronix.de>
References: <20110518205713.947614271@linutronix.de>
Message-ID: <20110519093403.GD6251@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The series provides a few improvements to the core code of
> clocksources and clockevents.
> 
> 1) Better layout and cacheline alignment of the hotpath data in both
>    data structures
> 
> 2) Get rid of the hardcoded 5 seconds sleep limit in clocksources
> 
> 3) Provide a generic configuration and registration interface for
>    clockevents which does all the common math tasks so we can remove
>    copied code all over the place
> 
> 4) Provide a function to reconfigure an active clock event
>    device. Needed by devices which are affected by frequency scaling.
> 
> The last two patches are x86 specific and make use of the new
> config_register() functions.

Nice! Other than the comments i made for specific patches it's looking good to 
me:

Reviewed-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
