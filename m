From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 22 Jul 2014 10:10:13 -0700
Subject: [PATCH v2] platform: Make platform_bus device a platform device
In-Reply-To: <1406023327-18525-1-git-send-email-pawel.moll@arm.com>
References: <20140721184007.GB572@kroah.com>
 <1406023327-18525-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140722171013.GA6605@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 11:02:07AM +0100, Pawel Moll wrote:
> ... describing the root of the device tree, so one can write
> a platform driver initializing the platform.
> 
> All references to platform_bus device have been fixed up,
> although in most cases they could be simply removed or
> replaced by NULL (platform devices with no parent are adopted
> by main platform_bus device automagically).

In looking at this some more, I think all of these should be made NULL,
why are we exporting this symbol at all?

I think we should remove all of these references, and just make
platform_bus static, like all other busses are, no reason platform
should be "special" here.  It's "special" enough as it is :(

thanks,

greg k-h
