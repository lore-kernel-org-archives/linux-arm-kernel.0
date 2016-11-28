From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Nov 2016 17:15:25 +0100
Subject: arasan,sdhci.txt "compatibility" DT binding
In-Reply-To: <583C50E7.6030400@free.fr>
References: <56B07BA5.4060407@free.fr>
 <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com> <583C50E7.6030400@free.fr>
Message-ID: <14771688.Q8f97gHC2H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 28, 2016 4:44:39 PM CET Mason wrote:
> Hello,
> 
> @Shawn Lin, could you take a look below and tell me exactly
> which IP core(s) Rockchip is using in its SoCs?
> 
> Based on the feedback I received, here is an updated list of
> compatible strings and controller versions dealt with by the
> drivers/mmc/host/sdhci-of-arasan.c code.
> 
> 
> Xilinx Zynq:
> "SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: 8.9a is the documentation revision (dated 2011-10-19)
> subsequent tweaks labeled 9.0a, 9.1a, 9.2a
> 
> Xilinx ZynqMP:
> "SD3.0 / SDIO3.0 / eMMC4.51 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: using the same compatible string as Zynq
> 
> Sigma SMP87xx
> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
> no compatible string yet, platform-specific init required
> 
> APM:
> "SD3.0 / SDIO3.0 / eMMC4.41 AHB Host Controller"
> "arasan,sdhci-4.9a"
> NB: 4.9a appears to be the documentation revision
> no functional diff with "arasan,sdhci-8.9a"
> 
> Rockchip
> Exact IP unknown, waiting for Shawn's answer
> "arasan,sdhci-5.1"
> NB: 5.1 appears to refer to the eMMC standard supported
> 
> 
> On a final note, there are many variations of the Arasan IP.
> I've tracked down at least the following:
> 
> SD_2.0_SDIO_2.0__MMC_3.31_AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.41_OCP_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller.pdf
> 
> It seems to me the compatible string should specify
> the SD/SDIO version AND the eMMC version, since it
> seems many combinations are allowed, e.g. eMMC 4.51
> has two possible SD versions.
> 
> What do you think?

It seems wrong to have the eMMC or SD version in the compatible
string.  Is that the only difference between the documents you
found? Normally there should be a version of IP block itself,
besides the supported protocol.

	Arnd
