From: greg@kroah.com (Greg KH)
Date: Mon, 12 Aug 2013 13:22:49 -0700
Subject: [PATCH V2] USB: OHCI: make ohci-nxp a separate driver
In-Reply-To: <1376120655-31149-1-git-send-email-manjunath.goudar@linaro.org>
References: <1372585818-8441-1-git-send-email-manjunath.goudar@linaro.org>
 <1376120655-31149-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <20130812202249.GA26423@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 01:14:15PM +0530, Manjunath Goudar wrote:
> Separate the OHCI NXP host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.
> 
> Many place function name and struct name started with usb,
> current scenario replaced usb with ohci for proper naming.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> 
> V2:
>   - Directive check NXP_PLATFORM_DRIVER block has been removed.
> ---
>  drivers/usb/host/Kconfig    |    8 +++
>  drivers/usb/host/Makefile   |    1 +
>  drivers/usb/host/ohci-hcd.c |   18 -------
>  drivers/usb/host/ohci-nxp.c |  124 +++++++++++++++++--------------------------
>  4 files changed, 58 insertions(+), 93 deletions(-)

Also failed to apply:

checking file drivers/usb/host/Kconfig
Hunk #1 FAILED at 398.
1 out of 1 hunk FAILED
checking file drivers/usb/host/Makefile
Hunk #1 FAILED at 50.
1 out of 1 hunk FAILED
checking file drivers/usb/host/ohci-hcd.c
Hunk #1 succeeded at 1212 with fuzz 1 (offset 18 lines).
Hunk #2 succeeded at 1349 with fuzz 1 (offset 53 lines).
Hunk #3 FAILED at 1309.
Hunk #4 FAILED at 1357.
2 out of 4 hunks FAILED
checking file drivers/usb/host/ohci-nxp.c

{sigh}

That's why I required a senior Linaro developer to approve these
patches.  You just wasted a bunch of my time, and it was obvious that no
one else actually tried these patches out, as they can't even be
applied!

Deepak, come on, you know better :(

greg k-h
