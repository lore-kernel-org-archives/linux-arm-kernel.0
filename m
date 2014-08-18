From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Aug 2014 11:37:57 -0500
Subject: [PATCH v7] 8250-core based serial driver for OMAP + DMA
In-Reply-To: <53F21885.605@hurleysoftware.com>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <20140815181704.GH17769@csclub.uwaterloo.ca>
 <53EE5BF8.3010007@linutronix.de>
 <20140815202826.GC9239@atomide.com>
 <53F21885.605@hurleysoftware.com>
Message-ID: <20140818163757.GK9662@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 11:15:17AM -0400, Peter Hurley wrote:
> On 08/15/2014 04:28 PM, Tony Lindgren wrote:
> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140815 12:16]:
> >> On 08/15/2014 08:17 PM, Lennart Sorensen wrote:
> >>
> >>> Are you saying that with the new driver you have to respond to the RX
> >>> irq faster than before to avoid overflows?  It is not quite clear.
> >>
> >> Yes. The irq fires 46 bytes giving you 16 bytes buffer before overflow
> >> vs 63 bytes buffer the old one had.
> >>
> >>> I do think 40000 interrupts to handle 40000 bytes of date does seem a
> >>> tad inefficient, so dropping to 854 looks a lot nicer.  Was the omap
> >>> driver not using the fifo trigger levels at all?
> >>
> >> It configured the trigger levels to 1 for RX and 16 for TX.
> > 
> > Hmm that weird RX trigger level is a workaround for lost characters.
> > 
> > See commit 0ba5f66836 (tty: serial: OMAP: use a 1-byte RX FIFO
> > threshold in PIO mode :)
> 
> That commit looks like it should have been specific to the silicon
> exhibiting the rx timeout bug.

yeah, I'll agree with that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/15050e1d/attachment.sig>
