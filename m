From: pavel@denx.de (Pavel Machek)
Date: Fri, 29 Mar 2013 11:16:03 +0100
Subject: [PATCH v6 0/8] Reset controller API to reset IP modules on
 i.MX5 and i.MX6
In-Reply-To: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130329101602.GA7283@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2013-03-28 17:35:15, Philipp Zabel wrote:
> [Added Arnd and Greg to the recipients] I think the first three patches
> of this series are candidates to go through Arnd's tree. Arnd, would you
> take those patches?
>         [PATCH v6 1/8] dt: describe base reset signal binding
>         [PATCH v6 2/8] reset: Add reset controller API
>         [PATCH v6 3/8] reset: Add driver for gpio-controlled reset pins
> 
> The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
> 
> The following patches add a simple API for devices to request being reset
> by separate reset controller hardware and implements the reset signal
> device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
> the i.MX SRC contains self-deasserting reset registers, so I've included
> both ops to manually assert/deassert a reset line, as well as a "reset"
> operation that is supposed to assert the reset line and wait for it to
> deassert.
> 
> The i.MX SRC is enhanced to provide a reset controller and the IPU driver
> is made to request being reset by calling the device_reset(&pdev->dev)
> convenience wrapper during probing.
> 
> No changes since v5, I just reordered the series.

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
