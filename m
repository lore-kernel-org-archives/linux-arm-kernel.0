From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 01:47:51 +0100
Subject: [PATCHv4 1/4] arm: dts: Add support for SD/MMC on SOCFPGA
In-Reply-To: <1386281452.26656.8.camel@linux-builds1>
References: <1386263677-7733-1-git-send-email-dinguyen@altera.com>
 <201312052208.38342.arnd@arndb.de> <1386281452.26656.8.camel@linux-builds1>
Message-ID: <201312060147.51489.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 December 2013, Dinh Nguyen wrote:
> Perhaps Seungwon and Chris might have an opinion on this:
> 
> From the Synopsys databook for this IP, using the SDMMC_CMD_USE_HOLD_REG
> is not recommended for SDR104, SDR50 and DDR50 speed modes. For other
> speeds, SDR12, and SDR25, it would be necessary to use
> SDMMC_CMD_USE_HOLD_REG.
> 
> I am referencing v2.50a of the Synopsys DesignWare Cores Mobile Storage
> Host Databook.
> 
> So I think a binary DT property should suffice?

Well, if it depends on the interface speed, it is something the driver should
actually be able to figure out itself, since it knows the speed that is used.

That way, you don't even need a property or per-platform compatible string.

	Arnd
