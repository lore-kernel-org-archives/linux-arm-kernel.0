From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 12 Jun 2013 11:11:06 +0200
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
Message-ID: <2722548.PBMM2Yn19A@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 15:10:03 Alan Stern wrote:
> In order to prevent this from happening, you would have to change the
> spin_lock() call in the completion handler to spin_lock_irqsave().  
> Furthermore, you will have to audit every USB driver to make sure that
> all the completion handlers get fixed.

Yes. However, it can be done mechanically. And we know only
the handlers for complete need to be fixed.

	Regards
		Oliver
