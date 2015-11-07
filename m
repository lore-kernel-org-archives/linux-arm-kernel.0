From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Nov 2015 23:02:37 +0000
Subject: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
In-Reply-To: <563E7CF2.60609@hurleysoftware.com>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
 <563C07C8.9060506@hurleysoftware.com>
 <563C09BB.9030706@codeaurora.org>
 <563C1409.4070804@hurleysoftware.com>
 <563CF8AF.50808@codeaurora.org> <563E7CF2.60609@hurleysoftware.com>
Message-ID: <20151107230237.GU8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 07, 2015 at 05:36:34PM -0500, Peter Hurley wrote:
> On 11/06/2015 01:59 PM, Timur Tabi wrote:
> > On 11/05/2015 08:44 PM, Peter Hurley wrote:
> >> Or better yet, for sbsa32 earlycon, just use the existing port type constructs.
> >> So,
> >>
> >>     earlycon=pl011,mmio32,0x3ced1000
> >>
> >> which will set port->iotype to UPIO_MEM32, which in turn can be used to select
> >> the correct i/o width in pl011_putc().
> > 
> > That's a great idea.  But why aren't we using it for pl011_write()?
> 
> I'll note that when I review Russell's v2 series, if necessary.

And I'm not rushing to post them yet as the merge window is currently
open.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
