From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 22 Jul 2014 15:16:19 -0700
Subject: [PATCH v3] platform: Make platform_bus device a platform device
In-Reply-To: <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
References: <20140722173713.GA8959@kroah.com>
 <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140722221619.GA15781@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 06:55:19PM +0100, Pawel Moll wrote:
> ... describing the root of the device tree, so one can write
> a platform driver initializing the platform.
> 
> There has been a lot of references to platform_bus device where
> it didn't make any sense, because simply using NULL as a parent
> will make the device be adopted by the top level anyway.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> Changes since v2:
> 
> * replaced references to platform_bus.dev with NULL
>   in places where it shouldn't make any difference

How about split this up with just the "change to NULL" changes as one
patch, and the rest as a second one?

thanks,

greg k-h
