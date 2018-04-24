From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 24 Apr 2018 14:47:05 +0530
Subject: [PATCH 0/3] cpufreq: dt: Allow platforms to provide
 suspend/resume hooks
In-Reply-To: <20180424110825.50436168@xps13>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
 <20180424110825.50436168@xps13>
Message-ID: <20180424091705.ar6vzzuljjz44qp5@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-04-18, 11:08, Miquel Raynal wrote:
> I tested on an EspressoBin (Armada 3720), it works.

Great.

> However, I first had a panic due to the clock being 'put' twice. I
> suggest you to merge this [1] into the second patch. With this (or
> something similar):

NULL is a valid clock. I have fixed it now, a bit differently though.

> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks.

> And the path error was reached because I did not select the cpufreq-dt
> driver in menuconfig, which I think should be selected by default when
> enabling the armada37xx-cpufreq driver. I wrote a small patch for
> that too, see [2]. Tell me if you want me to send it of if you want to
> include it in the next version ?

Maybe just send that separately (and you don't need to resend any of
the patches which are part of this series).

-- 
viresh
