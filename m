From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 22 Nov 2017 08:53:02 +0100
Subject: [PATCH 12/30] Drivers: ide: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-13-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-13-git-send-email-okaya@codeaurora.org>
Message-ID: <20171122075302.GB26583@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:30:57AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.

While this is a great generic text, you might want to make it a bit more
custom to each specific patch.  For example, you don't use a domain of 0
in this one, so the text is a bit wrong and confusing if you look at it
stand-alone.

I like the series and the idea, just fix up this text in some of the
patches and you should be fine.

thanks,

greg k-h
