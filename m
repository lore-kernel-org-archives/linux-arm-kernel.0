From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 12:14:04 +0100
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <1494890913-8360-2-git-send-email-mw@semihalf.com>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
Message-ID: <20170516111404.GB22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 01:28:32AM +0200, Marcin Wojtas wrote:
> +&cpm_sdhci0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	no-1-8-v;
> +	non-removable;
> +};

Testing the latest free-electrons sdhci driver (that was merged in 4.12-rc1)
_fails_ on mcbin, with it spewing:

mmc1: Timeout waiting for hardware cmd interrupt.
mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
mmc1: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000001
mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00003947
mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00018000
mmc1: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000001
mmc1: sdhci: Caps:      0x35ee0099 | Caps_1:   0x0000af77
mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc1: sdhci: Host ctl2: 0x00000000
mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000000000000
mmc1: sdhci: ============================================

It doesn't matter if I use my DT or your DT fragment above.  This used
to work fine with the previous revision of the sdhci-xenon driver.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
