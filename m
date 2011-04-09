From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 9 Apr 2011 10:53:48 +0300
Subject: [PATCH] ux500: Adding support for u8500 Hsem functionality.
In-Reply-To: <1302294509-6595-1-git-send-email-mathieu.poirier@linaro.org>
References: <1302294509-6595-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <BANLkTikMy7vpz8z479sCuROgjV8EK03FUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Fri, Apr 8, 2011 at 11:28 PM,  <mathieu.poirier@linaro.org> wrote:
...

> + * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
> + * Heavily borrowed from the work of :
> + * ? Simon Que <sque@ti.com>
> + * ? Hddari Kanigeri <h-kanigeri2@ti.com>

s/Hddari/Hari/

> + ? ? ? platform_set_drvdata(pdev, state);
> +
> + ? ? ? /* no pm needed for HSem but required to comply
> + ? ? ? ?* with hwspilock core.
> + ? ? ? ?*/
> + ? ? ? pm_runtime_enable(&pdev->dev);

You seem to have removed the calls to pm_runtime_disable() throughout
the driver, is that on purpose ?

You should see an "Unbalanced pm_runtime_enable!" warning about this
if you tried rmmod'ing and insmod'ing the driver again.

And just a minor comment if you're submitting a v2: you have a bunch
of trailing whitespaces; try checkpatch to spot them easily.

Thanks,
Ohad.
