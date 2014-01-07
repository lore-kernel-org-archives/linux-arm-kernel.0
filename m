From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 7 Jan 2014 17:44:01 +0530
Subject: [PATCH] ARM: tegra: Remove 3.3V supply and modem regulators
In-Reply-To: <52CB192F.2020700@wwwdotorg.org>
References: <1389021933-6675-1-git-send-email-treding@nvidia.com>
 <52CB192F.2020700@wwwdotorg.org>
Message-ID: <52CBEF89.6090901@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 02:29 AM, Stephen Warren wrote:
> On 01/06/2014 08:25 AM, Thierry Reding wrote:
>> GPIO 1 and 2 of the PMIC are not used for the described purpose, so
>> remove them.
> As far as I can tell, this patch is correct, since those GPIOs are in
> fact used to discharge the rails after disabling them, rather than to
> enable/disable the rails.
>
> Equally, these GPIOs affect multiple rails at once, so listing the GPIO
> as a property of a single regulator seems wrong either way.
>
> However, PMU_REGEN1 does seem to feed the "EN" pin of U13C1, a DC/DC
> switcher for power rail 3.3v_modem, so perhaps there's more going on
> here than I see?
>
> In summary, I need Laxman to comment on this and ack the change, and
> explain why these GPIOs were listed as regulator enables when it doesn't
> seem that they are.
>
PMU_REGEN1 is going to U13C1 (DCDC switcher). So if EN is 0, the output 
will be 0 and when it is 1, the output will be 3.3V.
Because this is coming from GPIO, it is added as the fixed regulator.
