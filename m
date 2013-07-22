From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 22 Jul 2013 16:18:15 +0400
Subject: [PATCH 04/11] USB: OHCI: Properly handle ohci-da8xx suspend
In-Reply-To: <1374485566-3997-5-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1374485566-3997-1-git-send-email-manjunath.goudar@linaro.org>
 <1374485566-3997-5-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51ED2307.1040207@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-07-2013 13:32, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-da8xx glue was not
> properly handled as it was not suspending generic part
> of ohci controller. Calling explicitly the ohci_suspend()
> routine in ohci_da8xx_suspend() will ensure proper
> handling of suspend scenario.

> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org

> V2:
>   -Incase ohci_suspend() fails, return right away without
>    executing further.

> V3:
>   -Aligned variable "do_wakeup" and "ret".
>   -pdev->dev.power.power_state stuff has been removed.

> V4:
>   -Properly aligned "do_wakeup" and "ret" variable.
> ---
>   drivers/usb/host/ohci-da8xx.c |   15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index 6aaa9c9..c649a35 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -406,19 +406,26 @@ static int ohci_hcd_da8xx_drv_remove(struct platform_device *dev)
>   }
>
>   #ifdef CONFIG_PM
> -static int ohci_da8xx_suspend(struct platform_device *dev, pm_message_t message)
> +static int ohci_da8xx_suspend(struct platform_device *pdev,
> +		pm_message_t message)

    Please start this line under *struct* above. Don't break the coding style 
we used in this file.

WBR, Sergei
