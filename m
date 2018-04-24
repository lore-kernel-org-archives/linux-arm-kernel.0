From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 24 Apr 2018 11:08:25 +0200
Subject: [PATCH 0/3] cpufreq: dt: Allow platforms to provide
 suspend/resume hooks
In-Reply-To: <cover.1524549644.git.viresh.kumar@linaro.org>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
Message-ID: <20180424110825.50436168@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Tue, 24 Apr 2018 11:37:33 +0530, Viresh Kumar
<viresh.kumar@linaro.org> wrote:

> Hi Miquel,
> 
> This is in response to the patch[1] you sent.

Thank you very much for taking the time to look into it.

> 
> I have updated the cpufreq-dt driver to allow platform specific
> suspend/resume hooks and done some minor cleanup in the driver. I have
> updated your patch and applied that on top of all this. I haven't tested
> any of this and would need your help to get that done.

I tested on an EspressoBin (Armada 3720), it works.

However, I first had a panic due to the clock being 'put' twice. I
suggest you to merge this [1] into the second patch. With this (or
something similar):

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

And the path error was reached because I did not select the cpufreq-dt
driver in menuconfig, which I think should be selected by default when
enabling the armada37xx-cpufreq driver. I wrote a small patch for
that too, see [2]. Tell me if you want me to send it of if you want to
include it in the next version ?

[1] http://code.bulix.org/auzdqa-323646
[2] http://code.bulix.org/e1yk5h-323647

Thank you,
Miqu?l


> 
> Thanks.
> 
> --
> viresh
> 
> [1] https://lkml.kernel.org/r/20180421141943.25705-1-miquel.raynal at bootlin.com
> 
> Miquel Raynal (1):
>   cpufreq: add suspend/resume support in Armada 37xx DVFS driver
> 
> Viresh Kumar (2):
>   cpufreq: dt: Allow platform specific suspend/resume callbacks
>   cpufreq: armada: Free resources on error paths
> 
>  drivers/cpufreq/armada-37xx-cpufreq.c | 107 +++++++++++++++++++++++++++++-----
>  drivers/cpufreq/cpufreq-dt.c          |  10 +++-
>  drivers/cpufreq/cpufreq-dt.h          |   5 ++
>  3 files changed, 104 insertions(+), 18 deletions(-)
> 



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
