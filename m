From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Mon, 25 Jun 2012 18:48:06 +0530
Subject: [PATCH v7 04/14] usb: chipidea: msm: add remove method
In-Reply-To: <1340607391-16380-5-git-send-email-richard.zhao@freescale.com>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <CAAe_U6JJe4U+oMR+xj4TwdNsXEzHNhQ0+t-PUPJT=kezHCqL2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 25, 2012 at 12:26 PM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> From: Felipe Balbi <balbi@ti.com>
>
> allow this driver to be removed too.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
> ?drivers/usb/chipidea/ci13xxx_msm.c | ? 20 ++++++++++++++------
> ?1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci13xxx_msm.c b/drivers/usb/chipidea/ci13xxx_msm.c
> index 8d438b8..68512d4 100644
> --- a/drivers/usb/chipidea/ci13xxx_msm.c
> +++ b/drivers/usb/chipidea/ci13xxx_msm.c
> @@ -84,6 +84,8 @@ static int __devinit ci13xxx_msm_probe(struct platform_device *pdev)
> ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ?goto put_platform;
>
> + ? ? ? platform_set_drvdata(pdev, plat_ci);
> +
> ? ? ? ?pm_runtime_no_callbacks(&pdev->dev);
> ? ? ? ?pm_runtime_enable(&pdev->dev);
>
> @@ -95,16 +97,22 @@ put_platform:
> ? ? ? ?return ret;
> ?}
>
> +static int __devexit ci13xxx_msm_remove(struct platform_device *pdev)
> +{
> + ? ? ? struct platform_device *plat_ci = platform_get_drvdata(pdev);

How about a pm_runtime_disable() here?

> +
> + ? ? ? platform_device_unregister(plat_ci);
> +
> + ? ? ? return 0;
> +}

Thanks
Kishon
