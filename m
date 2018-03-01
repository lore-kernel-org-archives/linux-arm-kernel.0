From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 1 Mar 2018 19:02:34 +0530
Subject: [PATCH 2/3] mailbox: Avoid NULL dereference in
 mbox_chan_received_data
In-Reply-To: <20180228022714.30068-3-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-3-samuel@sholland.org>
Message-ID: <CABb+yY04Fdv16RKAOZ=Tr7KnEOCJnXpGF0pEgy8DjREqEixiqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
> If a reception IRQ is pending when a mailbox channel is shut down (for
> example, if the controller uses threaded interrupts), it is possible for
> mbox_chan_received_data to be called while chan->cl is NULL.
>
We can add a check in mailbox.c, but that is like shoving it under the carpet.
How does your code look like?  mbox_chan_received_data() is meant to
be called from interrupt context as its documentation says.
Also the controller driver is responsible for ceasing any transient
xfer before returning from shutdown() callback.

Cheers!
