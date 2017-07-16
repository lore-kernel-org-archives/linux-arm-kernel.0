From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 16 Jul 2017 12:30:55 +0200
Subject: [PATCH 1/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <20170716023610.4658-2-f.fainelli@gmail.com>
References: <20170623010837.11199-1-f.fainelli@gmail.com>
 <20170716023610.4658-1-f.fainelli@gmail.com>
 <20170716023610.4658-2-f.fainelli@gmail.com>
Message-ID: <1787546.EYh03heFAd@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, July 15, 2017 07:36:09 PM Florian Fainelli wrote:
> Add an optional platform_suspend_ops callback: target_state, and a
> helper function globally visible to get this called:
> platform_suspend_target_state().
> 
> This is useful for platform specific drivers that may need to take a
> slightly different suspend/resume path based on the system's
> suspend/resume state being entered.
> 
> Although this callback is optional and documented as such, it requires
> a platform_suspend_ops::begin callback to be implemented in order to
> provide an accurate suspend/resume state within the driver that
> implements this platform_suspend_ops.
> 
> An enumeration: platform_target_state is defined which currently defines
> the standard ACPI_S[1-4] states and can be extended with platform
> specific suspend states.

This has a couple of problems, but I'm not sure if it is worth to go too much
into details here.

Let's just take a different approach as I said in the other thread.

Thanks,
Rafael
