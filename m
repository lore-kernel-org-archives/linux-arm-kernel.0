From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 22 Jan 2010 11:07:01 +0000
Subject: [PATCH] serial imx.c: fix CTS trigger level lower to avoid	lost
	chars
In-Reply-To: <4B597A82.4020906@epfl.ch>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
	<20100121220653.GA21010@pengutronix.de>
	<20100121221133.GA30419@n2100.arm.linux.org.uk>
	<4B597A82.4020906@epfl.ch>
Message-ID: <20100122110701.GA15699@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Valentin Longchamp wrote:
> First I wanted to fix the fact that the imx serial hardware only raises 
> the CTS pin when the oferflowing char begins to be set. I would have 
> solved this by setting the CTS trigger value to 31 instead of 32. But 
> when I talked with one colleague he told me about 16550A (that is 
> present nearly everywhere) that empty their TX FIFO, so I lowered it to 16.

That seems quite peculiar because a 16550A only has a 16 byte receive
buffer, doesn't it?  And therefore it would have trouble talking
reliably to another 16550A if it worked like that.  I wonder what I'm
not seeing in this picture.

-- Jamie
