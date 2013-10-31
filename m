From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Oct 2013 15:49:18 -0600
Subject: [PATCH 00/11] RFC: Common machine reset handling
In-Reply-To: <20131031062708.520968323@linux.com>
References: <20131031062708.520968323@linux.com>
Message-ID: <5272D05E.1070207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 12:27 AM, Domenico Andreoli wrote:
> Hi,
> 
>   I've been looking for a solution to my bcm4760 watchdog based restart
> hook when I noticed that the kernel reboot/shutdown mechanism is having
> a few unaddressed issues.
> 
> Those I identified are:
> 
>  1) context pointer often needed by the reset hook
>     (currently local static data is used for this pourpose)
>  2) unclear ownership/policy in case of multiple reset hooks
>     (currently almost nobody seems to care much)

I'm not sure how this patchset solves (2); even with the new API, it's
still the case that whichever code calls set_machine_reset() last wins,
just like before where whichever code wrote to pm_power_off won. I'm not
sure what this series attempts to solve.
