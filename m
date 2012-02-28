From: davem@davemloft.net (David Miller)
Date: Tue, 28 Feb 2012 14:13:34 -0500 (EST)
Subject: [PATCH v2] ARM: LPC32xx: Ethernet driver
In-Reply-To: <4F4CD1D8.8030102@antcom.de>
References: <4F4CD1D8.8030102@antcom.de>
Message-ID: <20120228.141334.569125676685228205.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roland Stigge <stigge@antcom.de>
Date: Tue, 28 Feb 2012 14:08:40 +0100

> For the case that it _isn't_ initialized already, is it the right thing
> to use a hard coded default MAC address to be replaced by the final one
> in userspace? (I found such examples in some current micrel/ and amd/
> drivers.)

You use a randomized ethernet address which can subsequently be fixed up
by userspace, and we have very specific interfaces to make this very
easy for you.  It even sets an attribute which userland can query to see
that the device has a randomized ethernet address rathern than a true
assigned permanent one.
