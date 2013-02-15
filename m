From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 15 Feb 2013 13:47:42 -0300
Subject: [V2 0/8] usb: ehci: more bus glues as separate modules
In-Reply-To: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
References: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <20130215164741.GA2442@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath,

Nice job!

On Fri, Feb 15, 2013 at 03:54:05PM +0530, Manjunath Goudar wrote:
> Separate the SOC On-Chip host controller driver from ehci-hcd
> host code into its own driver module
> 
> V2:
> Modified the patches, based on the first version review comments  
> 

If at all possible, I'd still like to see a better commit message
explaining why we need this at all, as it has been previously requested.

I guess there has been some discussion about this rework somewhere.
It would be nice to add a link to that discussion in the commit message
or in the cover letter so reviewers can have better context.


> Manjunath Goudar (8):
>   USB: EHCI: make ehci-spear a separate driver
>   USB: EHCI: make ehci-atmel a separate driver
>   USB: EHCI: make ehci-s5p a separate driver
>   USB: EHCI: make ehci-mv as separate static driver
>   USB: EHCI: make ehci-vt8500 a separate driver
>   USB: EHCI: make ehci-msm a separate driver
>   USB: EHCI: make ehci-w90X900 a separate driver
>   USB: EHCI: make ehci-orion a separate driver
> 
>  drivers/usb/host/Kconfig        |   40 +++++++++++++++--
>  drivers/usb/host/Makefile       |    9 +++-
>  drivers/usb/host/ehci-atmel.c   |   76 ++++++++++++++++----------------
>  drivers/usb/host/ehci-hcd.c     |   52 +++++-----------------
>  drivers/usb/host/ehci-msm.c     |   85 ++++++++++++++++--------------------
>  drivers/usb/host/ehci-mv.c      |   78 +++++++++++++++------------------
>  drivers/usb/host/ehci-orion.c   |   90 ++++++++++++++++++--------------------
>  drivers/usb/host/ehci-s5p.c     |   67 +++++++++++++++-------------
>  drivers/usb/host/ehci-spear.c   |   77 +++++++++++++++++----------------
>  drivers/usb/host/ehci-vt8500.c  |   73 ++++++++++++++-----------------
>  drivers/usb/host/ehci-w90x900.c |   91 +++++++++++++++++----------------------
>  drivers/usb/host/ehci.h         |    2 +-
>  12 files changed, 358 insertions(+), 382 deletions(-)
> 
> -- 
> 1.7.9.5
> 

Thanks a lot,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
