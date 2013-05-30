From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 30 May 2013 13:26:26 -0400 (EDT)
Subject: [RFC PATCH 2/2] USB: OHCI: add a name for the platform-private
 field
In-Reply-To: <1369907454-11003-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305301323300.1137-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Manjunath Goudar wrote:

> This patch adds an ohci->priv field for private use by OHCI
> platform drivers.
> 
> Until now none of the platform drivers has used this private space,
> but that's about to change in the next patch of this series.

As far as I'm concerned, this doesn't need to be in a patch of its own.  
It can be merged into the 1/3 patch of the previous series.  After all,
that patch adds the extra_priv_size field in ohci_driver_overrides,
which doesn't make much sense unless there's a way to refer to the
private part of the ohci_hcd structure.

Alan Stern
