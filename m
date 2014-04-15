From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 15 Apr 2014 13:57:51 -0400 (EDT)
Subject: [PATCH v2 2/4] USB: EHCI: Export the ehci_hub_control function
In-Reply-To: <534D69F3.2050006@wwwdotorg.org>
Message-ID: <Pine.LNX.4.44L0.1404151355430.1310-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Apr 2014, Stephen Warren wrote:

> On 04/15/2014 10:06 AM, Laurent Pinchart wrote:
> > Platform drivers sometimes need to perform specific handling of hub
> > control requests. Make this possible by exporting the ehci_hub_control()
> > function which can then be called from a custom hub control handler in
> > the default case.
> 
> I recall trying to do something like this in the past, but IIRC Alan
> Stern didn't want to make this easy for odd drivers needing this unusual
> case. Witness the comment right above the context of the modified code
> in ehci-tegra.c:
> 
> > diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> 
> /*
>  * The Tegra HW has some unusual quirks, which require Tegra-specific
>  * workarounds. We override certain hc_driver functions here to
>  * achieve that. We explicitly do not enhance ehci_driver_overrides to
>  * allow this more easily, since this is an unusual case, and we don't
>  * want to encourage others to override these functions by making it
>  * too easy.
>  */

Yeah.  I sort of changed my mind about that.  While this sort of 
overriding is still discouraged, we may as well reduce the penalty for 
doing it.

Alan Stern
