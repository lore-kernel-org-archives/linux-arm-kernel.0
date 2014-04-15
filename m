From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 16 Apr 2014 01:00:50 +0200
Subject: [PATCH v2 1/4] USB: OHCI: Export the ohci_hub_control function
In-Reply-To: <Pine.LNX.4.44L0.1404151358020.1310-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1404151358020.1310-100000@iolanthe.rowland.org>
Message-ID: <1489663.xkLJNqq9Pt@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Tuesday 15 April 2014 14:01:54 Alan Stern wrote:
> On Tue, 15 Apr 2014, Laurent Pinchart wrote:
> > Platform drivers sometimes need to perform specific handling of hub
> > control requests. Make this possible by exporting the ohci_hub_control()
> > function which can then be called from a custom hub control handler in
> > the default case.
> 
> You should also export ohci_hub_status_data(), since it also gets
> overridden by these other drivers.

OK, I'll submit v3.

> For ehci-hcd, this doesn't seem to matter since ehci_hub_status_data
> doesn't get overridden anywhere.

-- 
Regards,

Laurent Pinchart
