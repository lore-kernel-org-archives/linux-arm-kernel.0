From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 21 Sep 2012 18:06:22 +0100
Subject: [PATCH v2] arm: introduce a DTS for Xen unprivileged virtual
 machines
In-Reply-To: <1348156062-11476-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1348156062-11476-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1348247182.11116.245.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-20 at 16:47 +0100, Stefano Stabellini wrote:
> Given that the xenvm machine is based on vexpress but with an extremely
> limited selection of peripherals (the guest is supposed to use virtual
> devices instead), add "xen,xenvm" to the list of compatible machines in
> mach-vexpress.
> 
> 
> Changes in v2:
> 
> - remove include skeleton;
> - use #address-cells = <2> and #size-cells = <2>;
> - remove the debug bootargs;
> - use memory at 80000000 instead of memory;
> - remove the ranges and interrupt-map from the motherboard node;
> - set the machine compatible to "xen,xenvm-4.2", "xen,xenvm";
> - rename the dts file to xenvm-4.2.dts;
> - add "xen,xenvm" to the list of compatible DT strings to mach-vexpress.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: Pawel Moll <pawel.moll@arm.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/boot/dts/xenvm-4.2.dts      |   64 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-vexpress/Makefile.boot |    3 +-
>  arch/arm/mach-vexpress/v2m.c         |    1 +
>  3 files changed, 67 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/boot/dts/xenvm-4.2.dts

I'm still not 100% convinced that the DTS is really necessary there, but
as to the v2m.c change:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawel
