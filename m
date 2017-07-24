From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 24 Jul 2017 22:55:32 +0200
Subject: [PATCH v4] PM / suspend: Export pm_suspend_target_state
In-Reply-To: <20170718001925.25286-1-f.fainelli@gmail.com>
References: <20170717221059.6523-1-f.fainelli@gmail.com>
 <20170718001925.25286-1-f.fainelli@gmail.com>
Message-ID: <6617312.jcY15JS4JA@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 17, 2017 05:19:25 PM Florian Fainelli wrote:
> Have the core suspend/resume framework store the system-wide suspend
> state (suspend_state_t) we are about to enter, and expose it to drivers
> via pm_suspend_target_state in order to retrieve that. The state is
> assigned in suspend_devices_and_enter().
> 
> This is useful for platform specific drivers that may need to take a
> slightly different suspend/resume path based on the system's
> suspend/resume state being entered.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v4:
> - clear pm_suspend_target_state in Close label
> 
> Changes in v3:
> 
> - just export pm_suspend_target_state without a helper function
> 
> Changes in v2:
> 
> - rename platform_suspend_target_state() -> suspend_target_state()
> - directly export the suspend_state_t value and assign it in
>   suspend_devices_and_enter()

Applied, thanks!
