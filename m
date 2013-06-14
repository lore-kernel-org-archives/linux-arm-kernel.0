From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 14 Jun 2013 11:24:58 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306131526500.1561-100000@iolanthe.rowland.org>
References: <20130613184703.GA5701@kroah.com>
 <Pine.LNX.4.44L0.1306131526500.1561-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVPtZq4XWddBnP0ze2aecwXsuU+0OL8TP1Tb_5BrpJv9cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 3:41 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> The main reason for moving away from the current scheme is to reduce
> latency for other interrupt handlers.  Ming gave two examples of slow
> USB code that runs in hardirq context now; with his change they would
> run in softirq context and therefore wouldn't delay other interrupts so
> much.  (Interrupt latency is hard to measure, however.)

With the two trace points of irq_handler_entry and irq_handler_exit, the
interrupt latency(or the time taken by hard irq handler) isn't hard to measure.
One simple script can figure out the average/maximum latency for one irq
handler, like I did in 4/4.


Thanks,
--
Ming Lei
