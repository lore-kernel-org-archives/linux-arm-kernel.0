From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 16:28:38 +0100
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <CABb+yY2wTj5i-koQhD+dqNWaL4TvUYk1XP3YT0jE3oDZT57U4g@mail.gmail.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
	<20110721081138.GL26574@n2100.arm.linux.org.uk>
	<CABb+yY2obv5JMBiRSXS-4tSCYX+7nVVaA0Q7gurA+NndrGVuvA@mail.gmail.com>
	<CACRpkdaP5D=URqAXAytm9s2e9HRVMB-MzsKZeLJ9v6ktkJUCRA@mail.gmail.com>
	<CABb+yY2wTj5i-koQhD+dqNWaL4TvUYk1XP3YT0jE3oDZT57U4g@mail.gmail.com>
Message-ID: <20110721152838.GF28942@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 07:58:03PM +0530, Jassi Brar wrote:
> While that does make sense, it makes mandatory the ritual of calling
> DMA_SLAVE_CONFIG mandatory for most of the cases.
> And I think the effort to set fifo_addr for peripherals is overrated.

You have to do that anyway.  You're dealing with DMA engine drivers which
you don't know the implementation details of.

Think about it for a moment, please.  The point of the DMA engine
abstraction is to make DMA users independent of the DMA engine actually
being used.

That means all DMA engine drivers and all DMA engine users have to
provide a basic set of information to allow them to interact with each
other.

Encoding random bits of information into inappropriate places like FIFO
addresses into DMA engine platform data just means you might was well
stay with your private API, because that driver may never be able to
work with another DMA engine implementation.

So please, either do the job properly, or don't waste peoples time with
a half hearted mess of inappropriate platform data.
