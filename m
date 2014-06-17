From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 17 Jun 2014 18:50:01 +0200
Subject: [PATCH v2 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host controller
 driver
In-Reply-To: <419989CC-5106-4AF7-8911-617B51FD7395@codeaurora.org>
References: <1402676163-31574-1-git-send-email-galak@codeaurora.org>
 <14174621.WL9ndpHQ2Q@amdc1032>
 <419989CC-5106-4AF7-8911-617B51FD7395@codeaurora.org>
Message-ID: <3066194.ZkIxk6z9u6@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 17, 2014 10:42:36 AM Kumar Gala wrote:
> 
> On Jun 17, 2014, at 7:25 AM, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:

[...]

> >> +static struct platform_driver qcom_ahci_driver = {
> >> +	.probe = qcom_ahci_probe,
> >> +	.remove = ata_platform_remove_one,
> >> +	.driver = {
> >> +		.name = "qcom_ahci_qcom",
> >> +		.owner = THIS_MODULE,
> >> +		.of_match_table = qcom_ahci_of_match,
> >> +	},
> > 
> > This driver lacks PM suspend/resume support.  I assume that
> > the IPQ806x platform also doesn't support suspend/resume yet
> > (if so a comment in the driver code about this would be useful),
> > otherwise the driver should be fixed.
> 
> Correct, do you want the comment in the commit message or the driver itself?

I would prefer the comment in the driver itself.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
