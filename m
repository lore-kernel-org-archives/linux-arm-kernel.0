From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 28 Nov 2014 00:47:14 +0100
Subject: [PATCH v4 0/2] Add support for the rockchip mmc clock phases
 using the framework
In-Reply-To: <1417051827-12564-1-git-send-email-amstan@chromium.org>
References: <1417051827-12564-1-git-send-email-amstan@chromium.org>
Message-ID: <3766029.50NHsEnjv7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. November 2014, 17:30:25 schrieb Alexandru M Stan:
> For now all I have is the getter and setter for the phase, nothing that uses
> it (that is ready). You can test the getter like this:
> localhost ~ # cat /sys/kernel/debug/clk/clk_summary|grep sample -C 1
> sclk_sdio1                            0            0    24000000          0
> 0 sdio1_sample                       0            0    12000000          0
> 0 sdio1_drv                          0            0    12000000          0
> 90 --
> 	sclk_sdmmc                      1            1   297000000          0 0
> 		sdmmc_sample                 0            0   148500000          0 
134
> 		sdmmc_drv                    0            0   148500000          0 
90
> --
> 	sclk_sdio0                      1            1   100000000          0 0
> 		sdio0_sample                 0            0    50000000          0 0
> 		sdio0_drv                    0            0    50000000          0 
90
> 	sclk_emmc                       1            1   100000000          0 0
> 		emmc_sample                  0            0    50000000          0 0
> 		emmc_drv                     0            0    50000000          0 
180
> 
> Next thing that will come is some dts changes that will make use of these
> new clocks, and eventually mmc code will be changed to tune with these
> clocks. You can see some WIP on
> https://chromium-review.googlesource.com/#/c/227240

I've applied both patches to my clk branch.


Heiko
