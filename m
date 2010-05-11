From: greg@kroah.com (Greg KH)
Date: Tue, 11 May 2010 16:38:12 -0700
Subject: [PATCH 1/1 v2] ehci-mxc: Fix mx31 OTG host initialisation
In-Reply-To: <1273587274-8045-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1273587274-8045-1-git-send-email-philippe.retornaz@epfl.ch>
	<1273587274-8045-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20100511233811.GB31311@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 04:14:34PM +0200, Philippe R?tornaz wrote:
> On mx31 the OTG host initialisation fails if you need to have
> an ULPI transfert to initialize the PHY.
> 
> In order to be able to communicate with the PHY a complete reset
> of the usb host is needed. After the PHY initialization the host
> usb configuration registers need to be rewritten to avoid a host
> controller lockup.
> 
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
> ---
>  drivers/usb/host/ehci-mxc.c |   98 ++++++++++++++++++++++++++++++++++++++-----

This patch doesn't apply anymore, can you redo it against the linux-next
tree?

thanks,

greg k-h
