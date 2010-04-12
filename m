From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 12 Apr 2010 08:52:15 +0300
Subject: [RFC PATCH 0/2] pxa: enable USB host port 2 on PXA310
In-Reply-To: <cover.1270651775.git.grinberg@compulab.co.il>
References: <cover.1270651775.git.grinberg@compulab.co.il>
Message-ID: <4BC2B50F.6090102@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,
Any comments?

Igor Grinberg wrote:
> The USB port 2 on PXA310 is an OTG port which can be utilized by OHCI controller
> in host mode and by high-speed USB device controller in device mode.
> Enabling this port in host mode only still requires manipulation of UDC and
> OTG controller registers for proper USB PHY initialization.
> This patch series add a minimalistic implementation of PHY configuration mechanism
> that can be used across PXA310 based platforms.
> 
> Igor Grinberg (2):
>   [ARM] pxa: add minimal ULPI functionality for USB host port 2 on
>     PXA310.
>   [ARM] pxa/cm-x300: enable USB host port 2 on modules with PXA310 cpu.
> 
>  arch/arm/mach-pxa/Makefile      |    1 +
>  arch/arm/mach-pxa/cm-x300.c     |   65 +++++++++++
>  arch/arm/mach-pxa/pxa310-ulpi.c |  240 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-pxa/pxa310-ulpi.h |   85 ++++++++++++++
>  4 files changed, 391 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.c
>  create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.h
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Sincerely yours,
Mike.
