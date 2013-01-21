From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 21:49:14 +0000
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <Pine.LNX.4.44L0.1301211533580.24224-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1301211533580.24224-100000@netrider.rowland.org>
Message-ID: <201301212149.15139.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Alan Stern wrote:
> Is Manjunath aware of the first patch attached to this email message?
> 
>         http://marc.info/?l=linux-usb&amp;m=135843902916416&amp;w=2
> 

I would not expect so. Manjunath is still learning about the open
source processes, but he has also done a similar patch in his tree,
and one for most of the other ARM based platforms.

Manjunath: following up on the discussions we've had, I would suggest
you take a look at that patch, and do a comparison with your version
(apply it on the same base, then use git-diff to show the differences
between the version) and thing about whether your they are significant
or not.  Since Alan posted his version on the mailing list first, that's
the one that should get merged, but there might be something in it that
you can learn from it and that I did not see.

Alan, one comment about your version: You keep maintaining the
'#if IS_ENABLED' list in the main driver, which I think can actually
get removed now. Since the base driver can be built independent of
the presence of platform glue drivers, there is no need to forbid
it any more, and the #if block will cause merge conflicts for each
patch that converts or adds another platform. I think we can actually
get the same results by turning the Kconfig logic around and making
the platform glue drivers 'select USB_EHCI_HCD' than depending on
it.

	Arnd
