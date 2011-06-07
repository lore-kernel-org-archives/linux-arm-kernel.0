From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2011 09:15:27 +0100
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
Message-ID: <20110607081527.GB20929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 01:39:43PM +0530, Jassi Brar wrote:
> Unfortunately, no. There are some features of Samsung's DMA API that
> the drivers have come to rely upon.
> Besides, I am not particularly a fan of the generic API. And IIRC,
> neither is Ben Dooks, the designer of the
> Samsung's DMA API.

We are now at the point where this is non-optional.  If the generic API
doesn't fit what Samsung needs, then that needs to be discussed and
whatever problems there are need to be resolved.

Continuing the platform specific DMA APIs is not sustainable.

I'm getting rather fed up with Samsung needing custom this and that, and
refusing to use the generic infrastructure such as clkdev.  This attitude
needs to change NOW.

Fix your platform specific crap and start using the generic services.
