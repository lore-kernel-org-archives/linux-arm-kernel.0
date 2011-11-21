From: khilman@ti.com (Kevin Hilman)
Date: Mon, 21 Nov 2011 10:38:09 -0800
Subject: [PATCH v3] ARM: OMAP2+: hwmod: Add a new state to handle hwmods
 left enabled at init
In-Reply-To: <1321877570-4333-1-git-send-email-rnayak@ti.com> (Rajendra
 Nayak's message of "Mon, 21 Nov 2011 17:42:50 +0530")
References: <1321877570-4333-1-git-send-email-rnayak@ti.com>
Message-ID: <87vcqdqq26.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> An hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
> enabled state by the hwmod framework post the initial setup.
> Once a real user of the device (a driver) tries to enable it
> at a later point, the hwmod framework throws a WARN() about
> the device being already in enabled state.
>
> Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
> to identify such devices/hwmods. When the device/hwmod
> is requested to be enabled (the first time) by its driver/user,
> nothing except the mux-enable and a state change to '_HWMOD_STATE_ENABLED'
> is needed. The mux data is board specific and is unavailable during
> initial enable() of the device, done by the framework as part of
> setup().
>
> A good example of a such a device is an UART used as debug console.
> The UART module needs to be kept enabled through the boot, until the
> UART driver takes control of it, for debug prints to appear on
> the console.
>
> Acked-by: Kevin Hilman <khilman@ti.com>
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Looks like we need a

Tested-by: Govindraj Raja <govindraj.raja@ti.com>

here as well.   Thanks Govindraj for testing.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>


Kevin
