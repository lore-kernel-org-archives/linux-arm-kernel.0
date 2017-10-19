From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 19 Oct 2017 15:38:28 +0200
Subject: [PATCH] pinctrl: armada-37xx: Add edge both type gpio irq support
In-Reply-To: <20171019131003.9684-1-gregory.clement@free-electrons.com>
References: <20171019131003.9684-1-gregory.clement@free-electrons.com>
Message-ID: <20171019133828.GC6615@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 03:10:03PM +0200, Gregory CLEMENT wrote:
> From: Ken Ma <make@marvell.com>
> 
> Current edge both type gpio irqs which need to swap polarity in each
> interrupt are not supported, this patch adds edge both type gpio irq
> support.

So is the assumption here that you can handle the interrupt and flip
the edge, faster than it takes the signal to change?

If the software is too slow, you loose the following edge? And you
might loose the edge after that as well, since the software will at
some point handle the interrupt and reconfigure the edge, potentially
for the wrong edge?

Or am i missing something which makes this race free?

   Andrew
