From: marex@denx.de (Marek Vasut)
Date: Sat, 7 Dec 2013 13:55:45 +0100
Subject: =?utf-8?q?=E5=9B=9E=E5=A4=8D=EF=BC=9ARe=3A_i=2EMX6/PCIe_and_MSI?=
 =?utf-8?q?_interrupts?=
In-Reply-To: <5osi8whb6ebv6ffon2b3alai.1386368340782@email.android.com>
References: <201312061032.31944.jbe@pengutronix.de>
 <201312061515.50436.jbe@pengutronix.de>
 <5osi8whb6ebv6ffon2b3alai.1386368340782@email.android.com>
Message-ID: <201312071355.46007.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 06, 2013 at 11:19:05 PM, Richard Zhu wrote:
> Hi:
> I find a way make imx6 pcie msi/msix work without modify e1000e driver.
> But e1000e can?t work after suspend/resume.:(.
> The other ep devices (iwl wifi, xhci) can work well.
> I can post my modification next monday if you want.

Please do, thanks! :)

> Sent from Huawei Mobile
> 
> J?rgen Beisert <jbe@pengutronix.de>???
> 
> Hi Harro,
> 
> On Friday 06 December 2013 13:39:09 Harro Haan wrote:
> > [...]
> > Attached are my patches of the first attempt to get MSI working for
> > the i.MX6. It looks like MSI is working but MSIX is not in combination
> > with e1000e and SabreSD. I did some successful iperf tests in MSI
> > mode. I did the following hack in
> > drivers/net/ethernet/intel/e1000e/param.c to disable MSIX:
> > 
> > -             if (adapter->flags & FLAG_HAS_MSIX) {
> > +             if (!(adapter->flags & FLAG_HAS_MSIX)/*TEMP*/) {
> 
> Arrrgh, after applying this change it starts to work immediately. So many
> hours...
> 
> > My MSI tests are not successful when testing it with a Xilinx PCIe
> > development board, while this FPGA design works properly with FSL
> > imx_3.0.35 (or on x86).
> 
> Same here. Network chip works with MSI, PCIe FPGA does not.
> 
> Regards and thanks for your help,
> Juergen
> 
> --
> Pengutronix e.K.                              | Juergen Beisert            
> | Linux Solutions for Science and Industry      |
> http://www.pengutronix.de/  |

Best regards,
Marek Vasut
