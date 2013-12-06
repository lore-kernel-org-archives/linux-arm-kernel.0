From: jbe@pengutronix.de (=?iso-8859-15?q?J=FCrgen_Beisert?=)
Date: Fri, 6 Dec 2013 15:15:50 +0100
Subject: i.MX6/PCIe and MSI interrupts
In-Reply-To: <CAB5oZtC_X6Tk+6c5sZB06kDmhOgqmqW0_QG1GKWAJgqNpg2tag@mail.gmail.com>
References: <201312061032.31944.jbe@pengutronix.de>
 <201312061243.56069.marex@denx.de>
 <CAB5oZtC_X6Tk+6c5sZB06kDmhOgqmqW0_QG1GKWAJgqNpg2tag@mail.gmail.com>
Message-ID: <201312061515.50436.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harro,

On Friday 06 December 2013 13:39:09 Harro Haan wrote:
> [...]
> Attached are my patches of the first attempt to get MSI working for
> the i.MX6. It looks like MSI is working but MSIX is not in combination
> with e1000e and SabreSD. I did some successful iperf tests in MSI
> mode. I did the following hack in
> drivers/net/ethernet/intel/e1000e/param.c to disable MSIX:
>
> -		if (adapter->flags & FLAG_HAS_MSIX) {
> +		if (!(adapter->flags & FLAG_HAS_MSIX)/*TEMP*/) {

Arrrgh, after applying this change it starts to work immediately. So many 
hours...

> My MSI tests are not successful when testing it with a Xilinx PCIe
> development board, while this FPGA design works properly with FSL
> imx_3.0.35 (or on x86).

Same here. Network chip works with MSI, PCIe FPGA does not.

Regards and thanks for your help,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
