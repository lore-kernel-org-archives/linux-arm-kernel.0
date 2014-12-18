From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 18 Dec 2014 22:23:30 +0100
Subject: AT91 slow clock mode regression/fixes, improvement proposal
In-Reply-To: <20141218203904.GA25215@gradator.net>
References: <20141218203904.GA25215@gradator.net>
Message-ID: <20141218212330.GA19367@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 18, 2014 at 09:39:04PM +0100, Sylvain Rochet wrote:
> 
> About e0c8ba9b0ec3154e87da747098ee56e96ca3cee6:
> 
> I have mixed feeling about moving the PLL enabling from slow clock mode 
> to master clock mode. Starting PLL is almost all about waiting, waiting, 
> and waiting until they are stable enough to be used, the few CPU 
> instructions required to switch ON the PLL is nothing compared to the 
> wait time.
> 
> To be sure I benchmarked the required time to set up the UTMI PLL (using 
> a GPIO + scope) on my AT91SAM9G35-CM module in both slow clock and 
> master clock mode, I found out the required time to start up the PLL is, 
> as expected, -exactly- the same.
> 
> But, previously, we were waiting with the CPU in slow clock mode, when 
> the CPU power consumption is very very low, now we are waiting when the 
> CPU is in full speed, which is worse.
> 
> Or, I am missing something ?

Responding myself on this point, just did further mesurements, and... 
well, this can be discarded. I didn't notice at first that PLL startup 
time are only about to take ~500 us, which is a negligible amount of 
time and is actually a bit faster (just a bit) on master clock. I 
really should have checked the timing as well with PLL start up 
disabled, sorry :)

Sylvain
