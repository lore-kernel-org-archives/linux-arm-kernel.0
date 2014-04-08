From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 8 Apr 2014 22:59:48 +0900
Subject: [PATCH v2 0/2] Add PCI USB DT support for R8A7790/Lager reference
 board
In-Reply-To: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
References: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoSg+JLZ5AbiOnnfXjg3m86q5J2U675VhgmhP1jxmDmmLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Apr 8, 2014 at 7:35 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-v3.14-20140403' tag. Here we add the PCI USB device tree
> support on the R8A7790/Lager reference board. The patchset requires the
> 'pci-rcar-gen2' driver device tree support (just re-posted) in order to work.
>
> [1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
> [2/2] ARM: shmobile: lager: enable internal PCI

Thanks for your efforts. It is good to see that you are caring for
both r8a7790 and r8a7791 now.

By the way, have you decided how to use DT with the PHY driver? Just
integrating this portion seems of the hardware seems insufficient to
me.

I believe the PHY driver is also needed in the system for correct
runtime configuration of USB0 and USB2. So DT support is needed for
multiple drivers for correct operation in the DT case. Regardless it
is of course good to see DT support for this hardware block but it
would be useful to have a good overview of DT support for all
components involved in USB Host support to avoid committing to a
premature half-baked ABI.

/ magnus
