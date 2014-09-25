From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Sep 2014 14:33:55 -0700
Subject: [PATCH/RFC v2 04/12] PM / Domains: Add genpd attach/detach
 callbacks
In-Reply-To: <1410893339-6361-5-git-send-email-geert+renesas@glider.be> (Geert
 Uytterhoeven's message of "Tue, 16 Sep 2014 20:48:51 +0200")
References: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
 <1410893339-6361-5-git-send-email-geert+renesas@glider.be>
Message-ID: <7h61gbbd18.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> While a PM domain can enable PM runtime management of its devices' module
> clocks by setting
>
> 	genpd->dev_ops.stop = pm_clk_suspend;
> 	genpd->dev_ops.start = pm_clk_resume;
>
> this also requires registering the clocks with the pm_clk subsystem.
> In the legacy case, this is handled by the platform code, after
> attaching the device to its PM domain.
>
> When the devices are instantiated from DT, devices are attached to their
> PM domains by generic code, leaving no method for the platform-specific
> PM domain code to register their clocks.
>
> Add two callbacks, allowing a PM domain to perform platform-specific
> tasks when a device is attached to or detached from a PM domain.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Nice, I like this approach!

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
