From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 07 Mar 2012 15:38:52 +0400
Subject: [PATCH 10/15] watchdog/mpcore_wdt: Add support for dev_pm_ops
 interface
In-Reply-To: <b50542be97df8b90d3e7c696a8d13be707f581f9.1331115752.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <b50542be97df8b90d3e7c696a8d13be707f581f9.1331115752.git.viresh.kumar@st.com>
Message-ID: <4F5748CC.9020601@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-03-2012 14:27, Viresh Kumar wrote:

> This patch adds dev_pm_ops support for standby/slepp/hibernate.

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   drivers/watchdog/mpcore_wdt.c |   18 +++++++++---------
>   1 files changed, 9 insertions(+), 9 deletions(-)

> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
> index e02c02b..a099418 100644
> --- a/drivers/watchdog/mpcore_wdt.c
> +++ b/drivers/watchdog/mpcore_wdt.c
[...]
> @@ -384,40 +385,39 @@ static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
[...]
>   /* work with hotplug and coldplug */
>   MODULE_ALIAS("platform:mpcore_wdt");
>
>   static struct platform_driver mpcore_wdt_driver = {
>   	.probe		= mpcore_wdt_probe,
>   	.remove		= __devexit_p(mpcore_wdt_remove),
> -	.suspend	= mpcore_wdt_suspend,
> -	.resume		= mpcore_wdt_resume,
>   	.shutdown	= mpcore_wdt_shutdown,
>   	.driver		= {
>   		.owner	= THIS_MODULE,
>   		.name	= "mpcore_wdt",
> +		.pm = &mpcore_wdt_dev_pm_ops,

    Please align the right part of initializer like all above.

WBR, Sergei
