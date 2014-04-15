From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 15 Apr 2014 14:01:54 -0400 (EDT)
Subject: [PATCH v2 1/4] USB: OHCI: Export the ohci_hub_control function
In-Reply-To: <1397578005-3341-2-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <Pine.LNX.4.44L0.1404151358020.1310-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Apr 2014, Laurent Pinchart wrote:

> Platform drivers sometimes need to perform specific handling of hub
> control requests. Make this possible by exporting the ohci_hub_control()
> function which can then be called from a custom hub control handler in
> the default case.

You should also export ohci_hub_status_data(), since it also gets
overridden by these other drivers.

For ehci-hcd, this doesn't seem to matter since ehci_hub_status_data 
doesn't get overridden anywhere.

Alan Stern
