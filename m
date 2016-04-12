From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 09:30:34 +0200
Subject: [PATCH v9 05/20] PM / devfreq: Add new passive governor
In-Reply-To: <1460347078-15175-6-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CA41A.5050500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the new passive governor for DEVFREQ framework. The following
> governors are already present and used for DVFS (Dynamic Voltage and Frequency
> Scaling) drivers. The following governors are independently used for one device
> driver which don't give the influence to other device drviers and also don't
> receive the effect from other device drivers.
> - ondemand / performance / powersave / userspace
> 
> The passive governor depends on operation of parent driver with specific
> governos extremely and is not able to decide the new frequency by oneself.
> According to the decided new frequency of parent driver with governor,
> the passive governor uses it to decide the appropriate frequency for own
> device driver. The passive governor must need the following information
> from device tree:
> - the source clock and OPP tables
> - the instance of parent device
> 
> For exameple,
> there are one more devfreq device drivers which need to change their source
> clock according to their utilization on runtime. But, they share the same
> power line (e.g., regulator). So, specific device driver is operated as parent
> with ondemand governor and then the rest device driver with passive governor
> is influenced by parent device.
> 
> Suggested-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [tjakobi: Reported RCU locking issue and cw00.choi fix it]
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> [linux.amoon: Reported possible recursive locking and cw00.choi fix it]
> Reported-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/Kconfig            |   8 ++
>  drivers/devfreq/Makefile           |   1 +
>  drivers/devfreq/governor_passive.c | 207 +++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h            |  33 ++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 drivers/devfreq/governor_passive.c
> 

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
