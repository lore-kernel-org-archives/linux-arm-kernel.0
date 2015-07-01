From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 01 Jul 2015 23:57:57 +0200
Subject: [RFC PATCH 00/15] pwm: add support for atomic update
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <3250976.mr9RMtjrdC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Am Mittwoch, 1. Juli 2015, 10:21:46 schrieb Boris Brezillon:
> Hello Thierry,
> 
> This series adds support for atomic PWM update, or ITO, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
> 
> This implementation is still experimental, and I may have missed some key
> aspect, so any feedback are welcome.
> 
> Also note that I haven't protected the state update with any locking.
> That's because the existing config does not protect against concurrent
> access to a requested PWM device (see the pwm_config implementation).
> I guess the PWM framework assume the user will implement the proper locking
> scheme if it has to concurrently access the device.
> 
> The 5 first patches prepare the addition of the pwm_state concept, which
> will be used to allow atomic updates.
> The following patches introduce the pwm_state struct, initial state
> retrieval and atomic update concepts.
> 
> Patches 12 and 13 are showing how one can implement the initial state
> retrieval and atomic update features in a PWM driver (in this specific
> case I implemented it in the rockchip driver).
> 
> The last 2 patches are making use of those changes to improve the
> pwm-regulator driver (initializing the regulator state based on the
> initial PWM state).

at first I got very strange readings (very wrong values and wrong polarity), 
which resulted from the issues I pointed out in the replies to individual 
patches. After fixing these, the pwm read-back now returns exactly the expected 
values :-) .

And with the original voltage table from the Chromeos-devicetrees, the pwm-
regulator also returns the expected 1.2V that coreboot initially set.


Heiko
