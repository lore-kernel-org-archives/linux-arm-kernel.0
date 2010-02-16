From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 16 Feb 2010 10:44:26 -0500 (EST)
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF8073@dbde02.ent.ti.com>
Message-ID: <Pine.LNX.4.44L0.1002161042350.1716-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2010, Shilimkar, Santosh wrote:

> > Your original patch however kills ehci, ohci and uhci on some architectures.
> Well the patch was making _ONLY_ control transfers use PIO and rest of
> the transfer would still use dma. So not sure how much performance impact would
> be because of that.
> Another issue with that patch is there are few controllers which can't do PIO
> at all and hence the patch would broke those controllers.

More than "a few"!  None of the EHCI, OHCI, or UHCI controllers used in
Intel-compatible desktop and laptop systems can do PIO.  That's what 
Oliver meant.

Alan Stern
