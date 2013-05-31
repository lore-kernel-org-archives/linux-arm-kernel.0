From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 31 May 2013 10:04:37 -0700
Subject: [PATCH 00/11] drivers: Add Pinctrl PM support
In-Reply-To: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20130531170437.GA17591@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hebbar,

On Fri, May 31, 2013 at 03:43:00PM +0530, Hebbar Gururaja wrote:
> By optionally putting the pins into sleep state in the suspend [or in
> runtime_suspend] callback we can accomplish two things.
> - One is to minimize current leakage from pins and thus save power,
> - second, we can prevent the IP from driving pins output in an
> uncontrolled manner, which may happen if the power domain drops the
> domain regulator.
> 
> These states can be specified in the DT blob and corresponding driver
> can pick these states during probe & set the related values during
> idle/suspend.
> 
> Not all drivers support/has idle state. Drivers like i2c, spi, mmc has
> idle states and hence these drivers are updated to support all the
> three states
> - default  : during regular operation
> - idle : when the module is in idle state
> - sleep : when the module is in suspend state
> 
> For those drivers which doesn't support/have idle state (at least at
> the moment), only default & sleep state is added.

As with the original introduction of pinctrl states my question is: "Can
all of this be handled in the driver/bus core instead of adding a lot
of boilerplate code to the individual drivers".

Thanks.

-- 
Dmitry
