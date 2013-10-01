From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 1 Oct 2013 12:24:09 +0530
Subject: [PATCH 1/3] ahci: exynos: add ahci sata support on Exynos platform
In-Reply-To: <1380609183-21430-2-git-send-email-yuvaraj.cd@samsung.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
 <1380609183-21430-2-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <CAK9yfHxF76YjrdGo0-Yty5QcaJKhvtikWhxySoA6-NxjFDsuTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuvaraj,

On 1 October 2013 12:03, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> Exynos5250 contains one Synopsys AHCI SATA controller.The avalaible
> ahci_platform driver is not sufficient to handle the AHCI PHY and PHY
> clock related initialization.

> +err_out:
> +               platform_set_drvdata(pdev, NULL);

This is not necessary. Driver core clears it upon detach or failure.

> +               platform_device_put(ahci_pdev);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int exynos_ahci_remove(struct platform_device *pdev)
> +{
> +       struct exynos_ahci_priv *priv = platform_get_drvdata(pdev);
> +       struct platform_device *ahci_pdev = priv->ahci_pdev;
> +
> +       platform_device_unregister(ahci_pdev);
> +       platform_set_drvdata(pdev, NULL);

ditto

-- 
With warm regards,
Sachin
