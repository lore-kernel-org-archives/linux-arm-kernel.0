From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Feb 2016 09:04:05 -0800
Subject: [PATCH] Revert "regulator: tps65217: remove tps65217.dtsi file"
In-Reply-To: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
References: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160219170404.GH21202@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160219 06:14]:
> This reverts commit 8e6ebfaa9b384088002baa10f7534efa73a0794e.
> 
> Without the patch reverted regulators will not work. This prevents
> MMC to be working for example so the boards can not boot to
> MMC rootfs.
> 
> Tested it on beaglebone white and bisect also points to the
> reverted commit.
> The issue can be also fixed by adding "regulator-compatible =" to all board
> dts file for the regulators.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> I have noticed that bbw did not find the MMC with linux-next, but it turns out
> that even 4.5-rc4 is behaving the same way.
> I have run bisect and with this revert patch I can boot up fine.
> To be honest I don't know why the tps65217.dtsi has been deleted in the first
> place. 

I think initially the only real issue was the naming. The
tps65217.dtsi file should be just renamed to tps65217-am335x.dtsi
to make it clear that this configuration is commonly used for
most am335x boards.

I'll apply this revert into omap-for-v4.5/fixes as it fixes a
regression.

Thanks,

Tony
