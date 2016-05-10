From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 10 May 2016 09:55:56 +0300
Subject: [PATCH 10/23] mmc: core: disable auto retune during card
 detection process
In-Reply-To: <20160429074258.GA28427@shlinux2.ap.freescale.net>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
 <571A1D85.3020200@intel.com>
 <CAA+hA=R9JfV4ScuM=OZ3VHdSiQiMO9io8mQQDNXfkTwNv7RVvg@mail.gmail.com>
 <5721B602.6010306@intel.com>
 <20160428132249.GB27560@shlinux2.ap.freescale.net>
 <57230515.9030602@intel.com>
 <20160429074258.GA28427@shlinux2.ap.freescale.net>
Message-ID: <573185FC.5060506@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/16 10:42, Dong Aisheng wrote:
> And IMX6DL ARD is even worser due to it's using common
> mmc_send_tuning() function.
> root at imx6qdlsolo:~# 
> root at imx6qdlsolo:~# [  129.462564] sysrq: SysRq : Changing Loglevel
> [  129.466902] sysrq: Loglevel set to 8
> [  131.616078] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
> [  131.625311] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 6
> [  131.632133] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
> [  131.642121] mmc0: starting CMD13 arg 59b40000 flags 00000195
> [  131.648925] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x0 ESDHC_TUNE_CTRL_STATUS 0x0
> [  131.657818] mmc0: starting CMD19 arg 00000000 flags 00000035
> [  131.663518] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
> [  131.670835] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000

You should stop here because -123 is -ENOMEDIUM
