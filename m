From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Oct 2012 14:04:12 -0400 (EDT)
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <2721213.h9kKFkpVW0@flexo>
Message-ID: <Pine.LNX.4.44L0.1210241358090.1282-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Oct 2012, Florian Fainelli wrote:

> As long as no one enables both ehci-platform and ehci-ppc-of at the same time
> there is no problem. ehci-ppc-of should be removed in favor of ehci-platform
> and make sure that the specific quirk in ehci-ppc-of also gets ported, other 
> that I see no issue using "usb-ehci" as the least detailed compatible property
> name.

Suppose a DT board file is created for a oontroller which ehci-platform
can't handle.  Then by your proposal, the board file shouldn't have
"usb-ehci" in its compatible property.

Now later on, suppose ehci-platform is enhanced so that it can manage
that controller.  It's too late to update the board file because the
information has already been written to various firmwares.  The
enhanced ehci-platform would have to include a special entry to match
the controller.

Since this reasoning applies every time ehci-platform is updated, it 
seems reasonable to use the same approach right from the beginning.

Alan Stern
