From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Tue, 03 May 2011 15:29:58 -0400
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: Your message of "Tue, 03 May 2011 19:27:12 +0200."
	<20110503172712.GE6538@lunn.ch>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110503172712.GE6538@lunn.ch>
Message-ID: <26287.1304450998@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 May 2011 19:27:12 +0200, Andrew Lunn said:

> I can think of two different solutions: 
> 
> 1) Three functions: uart-3wire, uart-hw-flow, uart-hw-flow-modem.  The
>    first just has 2 pins, the second 4 and the last 8. The board code
>    selects one of these for the serial driver to use.
> 
> 2) Three functions: uart-core, uart-hw-flow, uart-mode.  The first has
>    2 pins, the second has 2 pins and the last 4 pins. The board code tells
>    the driver to use uart-core, plus say uart-hw-flow.

For this second solution, what happens if some bozo selects *only* uart-modem
but not uart-core?  If there's a strict ordering (hw-flow requires core, modem
requires both hw-flow and core), it's essentially the same thing as the first
solution.  If there's not a strict ordering (i.e you can select uart-modem
without uart-core), you need to come up with sane semantics.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110503/ccb5316f/attachment.sig>
