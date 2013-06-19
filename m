From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 19 Jun 2013 11:30:32 -0400 (EDT)
Subject: [RFC PATCH v1 2/6] USB: disable IRQs deliberately when calling
 complete()
In-Reply-To: <CACVXFVOYrAW48YFLesJDtwwqLj9aNzd5wm_LPUSFm3BS8NC3sg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306191126490.2026-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jun 2013, Ming Lei wrote:

> On Wed, Jun 19, 2013 at 12:36 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 18 Jun 2013, Ming Lei wrote:
> >
> >> We disable local IRQs here in case of running complete() by
> >> tasklet to avoid possible deadlock because drivers may call
> >> spin_lock() to hold lock which might be acquired in one hard
> >> interrupt handler.
> >>
> >> The local_irq_save()/local_irq_restore() around complete()
> >> will be removed if current USB drivers have been cleaned up
> >> and no one may trigger the above deadlock situation when
> >> running complete() in tasklet.
> >
> > This should be part of the first patch, not added on separately.
> 
> Yes, but I want to highlight the change since that will be removed
> after drivers have been cleaned up.

I don't think it's necessary to highlight anything, and it seems silly 
to add new code in one patch and then change it in the very next patch.

Alan Stern
