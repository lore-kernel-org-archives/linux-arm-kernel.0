From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 2 Oct 2013 10:38:58 -0400 (EDT)
Subject: [PATCH 06/11] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <1846936.2HI9dODJ1D@amdc1032>
Message-ID: <Pine.LNX.4.44L0.1310021036360.1293-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Oct 2013, Bartlomiej Zolnierkiewicz wrote:

> Maybe it would make sense to cleanup ohci_suspend() first (before adding
> new ohci_suspend() users) and remove unused do_wakeup parameter?

Not possible.  The do_wakeup parameter is part of a function prototype
shared by other callback routines (such as ehci_suspend()) that _do_
use the parameter.

Alan Stern
