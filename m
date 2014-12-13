From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 13 Dec 2014 20:46:42 +0100
Subject: [PATCH v2 1/4] pci: iProc: define Broadcom iProc PCIe binding
In-Reply-To: <548C0F80.2090300@broadcom.com>
References: <1418351817-14898-2-git-send-email-rjui@broadcom.com>
 <3907917.zNo7yttzkh@wuerfel> <548C0F80.2090300@broadcom.com>
Message-ID: <3383252.Ad6Qf0H2fa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 December 2014 11:05:52 Arend van Spriel wrote:
> 
> Makes sense. I think that is what Hauke meant by "adding
> additional support for registering to bcma". So the discovery info is a 
> piece of read-only memory in the chip. Its address is stored in the 
> chipcommon core register space. BCMA parses that memory blob resulting 
> in a list of cores which register address info. We could add DT support 
> in BCMA matching the compatible string and register a core for it.

Ah, interesting idea. That would mirror what we do for drivers/amba,
I like the idea.

> However, apart from the discovery info a "discoverable ARM AXI" chip has 
> a register space per core that provides common procedures like 
> enable/disable, reset, core status, which are implemented in BCMA. I am 
> not seeing that register space in the DT examples so I guess this IP 
> block is not there for iProc chips.

I wouldn't draw conclusions from the absence of some node. Maybe these
registers are present but just not used by the original BSP.

	Arnd
