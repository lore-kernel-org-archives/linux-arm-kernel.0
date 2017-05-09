From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 May 2017 22:30:13 -0300
Subject: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
In-Reply-To: <20170508150224.GA7458@collabora.com>
References: <20170508150224.GA7458@collabora.com>
Message-ID: <CAOMZO5DjFxAus3B03Om0xoqxKuY2TkbcjCY1YEUK9s_R8C_DNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, May 8, 2017 at 12:02 PM, Peter Senna Tschudin
<peter.senna@collabora.com> wrote:
> Hello Kishon,
>
> Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> linux-next and I could bisect until:
>
> commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> Author: Kishon Vijay Abraham I <kishon@ti.com>
> Date:   Wed Feb 15 18:48:14 2017 +0530
>
>     PCI: dwc: all: Split struct pcie_port into host-only and core structures

I can reproduce the same problem on a custom imx6q board with a PCI bridge chip.

Other mx6 boards without PCI bridge boot fine.

I haven't bisected it, but the problem for me does not happen on 4.11.
It happens only in linux-next.

The commit you mentioned above is from 4.11 and does not cause the
problem on my tests.

Can you double check if you really have issues with 4.11?
