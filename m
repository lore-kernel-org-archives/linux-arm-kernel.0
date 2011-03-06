From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 06 Mar 2011 16:37:08 +0300
Subject: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
In-Reply-To: <1299338962-5602-4-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-4-git-send-email-nm@ti.com>
Message-ID: <4D738E04.5090207@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-03-2011 18:29, Nishanth Menon wrote:

> Blindly setting a 1.2V setting

    Hm, seems tautological...

> in the initial structure may not even
> match the default voltages stored in the voltage table which are
> supported for the domain. For example, OMAP3430 core domain does not
> use 1.2V and ends up generating a warning on the first transition.

> Further, since omap2_set_init_voltage is called as part of the pm
> framework's initialization sequence to configure the voltage required
> for the current OPP, the call does(and has to) setup the system
> voltage(curr_volt as a result) using the right mechanisms appropriate
> for the system at that point of time. This also overrides
> initialization we are currently doing in voltage.c making it
> redundant. So, remove the wrong and redundant initialization.

> Signed-off-by: Nishanth Menon<nm@ti.com>

WBR, Sergei
