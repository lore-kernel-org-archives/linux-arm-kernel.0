From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 23 Nov 2016 23:11:21 +0100
Subject: reboot fails on at91sam9g20 with kernel 4.x
In-Reply-To: <2093786.uQmBVvCouf@ada>
References: <2093786.uQmBVvCouf@ada>
Message-ID: <20161123221121.pkkhwhgqig5elwa7@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/11/2016 at 17:13:05 +0100, Alexander Dahl wrote :
> The last message obviously comes from arch/arm/kernel/reboot.c and 
> something fails. ;-)
> 
> Searching the web I found someone having a similar problem here:
> 
> 	https://groups.google.com/forum/#!topic/acmesystems/vC_66zmcatk
> 
> Reboot works with 3.x kernels (if they run at all). I'll try a 4.1 
> tomorrow, but I would be happy if someone could assist me in debugging 
> this.
> 

Since 3.18, the shdwc and reset controller have their own drivers that
may or may not be compiled in the kernel. Can you check you have
CONFIG_POWER_RESET_AT91_POWEROFF and CONFIG_POWER_RESET_AT91_RESET set
in your configuration? Also, you probably want to check the DT definition
of the shdwc and the rstc.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
