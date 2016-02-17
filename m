From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 16 Feb 2016 19:42:56 -0800
Subject: [PATCH v13 4/4] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <1455642530-19103-5-git-send-email-fu.wei@linaro.org>
References: <1455642530-19103-1-git-send-email-fu.wei@linaro.org>
 <1455642530-19103-5-git-send-email-fu.wei@linaro.org>
Message-ID: <56C3EC40.6080500@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2016 09:08 AM, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> According to Server Base System Architecture (SBSA) specification,
> the SBSA Generic Watchdog has two stage timeouts: the first signal (WS0)
> is for alerting the system by interrupt, the second one (WS1) is a real
> hardware reset.
> More details about the hardware specification of this device:
> ARM DEN0029B - Server Base System Architecture (SBSA)
>
> This driver can operate ARM SBSA Generic Watchdog as a single stage watchdog
> or a two stages watchdog, it's set up by the module parameter "action".
> In the single stage mode, when the timeout is reached, your system
> will be reset by WS1. The first signal (WS0) is ignored.
> In the two stages mode, when the timeout is reached, the first signal (WS0)
> will trigger panic. If the system is getting into trouble and cannot be reset
> by panic or restart properly by the kdump kernel(if supported), then the
> second stage (as long as the first stage) will be reached, system will be
> reset by WS1. This function can help administrator to backup the system
> context info by panic console output or kdump.
>
> This driver bases on linux kernel watchdog framework, so it can get
> timeout from module parameter and FDT at the driver init stage.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Pratyush Anand <panand@redhat.com>
> Acked-by: Timur Tabi <timur@codeaurora.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
