From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 May 2013 10:27:10 -0400 (EDT)
Subject: [RFC V6 PATCH 1/3] USB: OHCI: prepare to make ohci-hcd a library
 module
In-Reply-To: <1369307506-4458-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305231026420.925-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Manjunath Goudar wrote:

> This patch prepares ohci-hcd for being split up into a core
> library and separate platform driver modules.  A generic
> ohci_hc_driver structure is created, containing all the "standard"
> values, and a new mechanism is added whereby a driver module can
> specify a set of overrides to those values.  In addition the
> ohci_restart(),ohci_suspend() and ohci_resume() routines need
> to be EXPORTed for use by the drivers.
> 
> Added ohci_setip(() and ohci_start() routine for to start the generic
> controller rather than each having its own idiosyncratic approach.
> This allow to clean duplicated code in most of SOC driver

This patch looks good.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
