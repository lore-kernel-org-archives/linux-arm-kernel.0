From: a.zummo@towertech.it (Alessandro Zummo)
Date: Sun, 15 Apr 2012 16:34:56 +0200
Subject: [PATCH v2] rtc: add support for Freescale SNVS RTC
In-Reply-To: <1334387237-23519-1-git-send-email-paul.liu@linaro.org>
References: <1334387237-23519-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120415163456.67cbac58@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 14 Apr 2012 15:07:17 +0800
"Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org> wrote:

> atic int snvs_rtc_proc(struct device *dev, struct seq_file *seq)
> +{
> +	struct rtc_drv_data *pdata = dev_get_drvdata(dev);
> +	void __iomem *ioaddr = pdata->ioaddr;
> +
> +	seq_printf(seq, "alarm_IRQ\t: %s\n",
> +		   (((readl(ioaddr + SNVS_LPCR)) & SNVS_LPCR_LPTA_EN) !=
> +		    0) ? "yes" : "no");
> +
> +	return 0;
> +}
> +

 Please consider removing this unless truly necessary.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
