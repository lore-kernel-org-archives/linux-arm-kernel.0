From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 Mar 2011 11:51:58 -0800
Subject: [PATCH 2/2] OMAP: PM: implement devices constraints APIs
In-Reply-To: <AANLkTikQOfsteZUAzSWjO-BbAW=ZEX22mhRUFHBMeFTR@mail.gmail.com>
	(Jean Pihet's message of "Wed, 9 Mar 2011 20:37:51 +0100")
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299698346-2768-1-git-send-email-j-pihet@ti.com>
	<AANLkTikQOfsteZUAzSWjO-BbAW=ZEX22mhRUFHBMeFTR@mail.gmail.com>
Message-ID: <87y64mbvoh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]

>> + ? ? ? if (pwrdm_read_pwrst(pwrdm) != new_state) {
>> + ? ? ? ? ? ? ? ret = omap_set_pwrdm_state(pwrdm, new_state);
>
> The function pwrdms_setup (called from omap3_pm_init for every pwrdm)
> runs late in the boot process and so it overwrites the registers
> values programmed by omap_set_pwrdm_state with the default values.
> Could the default values get written earlier in the boot process (e.g.
> at hwmod init) before the devices can put constraints on the power
> domains?

Yes, default vaules for each power domain's next state should probably
be written earlier in the boot.  Probably when the powerdomain is
initialized, or at least when this constraints framework is initialized.

Then, the initial states set in omap3_pm_init() can just be removed.

Kevin
