From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Nov 2014 10:35:06 +0100
Subject: [PATCH v3 0/2] Add support for the rockchip mmc clock phases
 using the framework
In-Reply-To: <1416344908-5975-1-git-send-email-amstan@chromium.org>
References: <1416344908-5975-1-git-send-email-amstan@chromium.org>
Message-ID: <3222595.cbGxNcWa4c@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. November 2014, 13:08:26 schrieb Alexandru M Stan:
> For now all I have is the getter and setter for the phase, nothing that uses
> it (that is ready). You can test the getter like this:
> localhost ~ # cat /sys/kernel/debug/clk/clk_summary|grep sample -C 1
>     sclk_sdio1                            0            0    24000000        
>  0 0 sdio1_sample                       0            0    12000000         
> 0 0 sdio1_drv                          0            0    12000000         
> 0 90 --
>           sclk_sdmmc                      1            1   297000000        
>  0 0 sdmmc_sample                 0            0   148500000          0 134
> sdmmc_drv                    0            0   148500000          0 90 --
>           sclk_sdio0                      1            1   100000000        
>  0 0 sdio0_sample                 0            0    50000000          0 0
> sdio0_drv                    0            0    50000000          0 90
> sclk_emmc                       1            1   100000000          0 0
> emmc_sample                  0            0    50000000          0 0
> emmc_drv                     0            0    50000000          0 180
> 
> Next thing that will come is some dts changes that will make use of these
> new clocks, and eventually mmc code will be changed to tune with these
> clocks.

As already said in v1, this looks nice to me, but I'll give Mike another day 
or two to voice possible concerns.


Heiko
