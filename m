From: khilman@ti.com (Kevin Hilman)
Date: Tue, 13 Dec 2011 15:53:20 -0800
Subject: [PATCH v5 0/6] PM QoS: implement the OMAP low level constraints
 management code
In-Reply-To: <1323706701-6627-1-git-send-email-j-pihet@ti.com> (jean pihet's
 message of "Mon, 12 Dec 2011 17:18:15 +0100")
References: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
Message-ID: <87zkewrpu7.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

jean.pihet at newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> . Implement the devices wake-up latency constraints using the global
>   device PM QoS notification handler which applies the constraints to the
>   underlying layer
> . Implement the low level code which controls the power domains next power
>   states, through the hwmod and pwrdm layers
> . Add cpuidle and power domains wake-up latency figures for OMAP3, cf. 
>   comments in the code and [1] for the details on where the numbers
>   are magically coming from
> . Implement the relation between the cpuidle and per-device PM QoS frameworks
>   in the OMAP3 specific idle callbacks.
>   The chosen C-state shall satisfy the following conditions:
>    . the 'valid' field is enabled,
>    . it satisfies the enable_off_mode flag,
>    . the next state for MPU and CORE power domains is not lower than the
>      state programmed by the per-device PM QoS.

I had a couple minor comments on this version, but after that, feel free
to add:

Reviewed-by: Kevin Hilman <khilman@ti.com>

after that, this series will go upstream through Paul.

Kevin
