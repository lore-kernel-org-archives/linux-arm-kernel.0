From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 2 Jan 2017 17:13:59 +0100
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <0717c63b-2e29-9ad1-7f01-39817980933f@atmel.com>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170102113155.GA16373@localhost.localdomain>
 <0717c63b-2e29-9ad1-7f01-39817980933f@atmel.com>
Message-ID: <20170102161359.GD3609@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 03:47:07PM +0100, Nicolas Ferre wrote:
> Le 02/01/2017 ? 12:31, Richard Cochran a ?crit :
> > This Cadence IP core is a complete disaster.
> 
> Well, it evolved and propose several options to different SoC
> integrators. This is not something unusual...
> I suspect as well that some other network adapters have the same
> weakness concerning PTP timestamp in single register as the early
> revisions of this IP.

It appears that this core can neither latch the time on read or write,
or even latch time stamps.  I have worked with many different PTP HW
implementations, even early ones like on the ixp4xx, and it is no
exaggeration to say that this one is uniquely broken.

> I suspect that Rafal tend to jump too quickly to the latest IP revisions
> and add more options to this series: let's not try to pour too much
> things into this code right now.

Why can't you check the IP version in the driver?

And is it really true that the registers don't latch the time stamps,
as Rafal said?  If so, then we cannot accept the non-descriptor driver
version, since it cannot possibly work correctly.

Thanks,
Richard
