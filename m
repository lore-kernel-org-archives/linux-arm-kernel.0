From: elendil@planet.nl (Frans Pop)
Date: Sat, 22 Aug 2009 07:13:16 +0200
Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
In-Reply-To: <200908220223.50588.marek.vasut@gmail.com>
References: <200908220223.50588.marek.vasut@gmail.com>
Message-ID: <200908220713.20637.elendil@planet.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut wrote:
> +static struct dev_pm_ops cm710_mmc_pm_ops = {
> +       .suspend = cb710_mmc_suspend,
> +       .resume = cb710_mmc_resume,
> +};

This is almost certainly wrong (same for the other drivers you converted) 
as they now no longer support hibernation, which requires different ops.
Please see: http://lkml.org/lkml/2009/7/25/118.

You also seem to have handled the #ifndef CONFIG_PM case incorrectly.
See http://lkml.org/lkml/2009/8/3/253 for an example how it can be done.

There have already been several threads on lkml discussing this. Please 
search for posts with dev_pm_ops in the subject if you want more 
information.

Also, please CC linux-pm at lists.linux-foundation.org on patches related to 
this conversion.

Cheers,
FJP
