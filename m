From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 22 Jan 2010 11:14:26 +0100
Subject: [PATCH] serial imx.c: fix CTS trigger level lower to avoid	lost
	chars
In-Reply-To: <20100121221133.GA30419@n2100.arm.linux.org.uk>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
	<20100121220653.GA21010@pengutronix.de>
	<20100121221133.GA30419@n2100.arm.linux.org.uk>
Message-ID: <4B597A82.4020906@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Thu, Jan 21, 2010 at 11:06:53PM +0100, Wolfram Sang wrote:
>> CCing linux-serial
>>
>> On Thu, Jan 21, 2010 at 10:26:03PM +0100, Valentin Longchamp wrote:
>>> The imx CTS trigger level is left at its reset value that is 32
>>> chars. Since the RX FIFO has 32 entries, when CTS is raised, the
>>> FIFO already is full. However, some serial port devices first empty
>>> their TX FIFO before stopping when CTS is raised, resulting in lost
>>> chars.
>> ? Isn't that a flaw of the other side? Have you spotted other serial drivers
>> doing the same as your patch?
> 
> Arguably, but it's common behaviour of 16550A's and similar.

First I wanted to fix the fact that the imx serial hardware only raises 
the CTS pin when the oferflowing char begins to be set. I would have 
solved this by setting the CTS trigger value to 31 instead of 32. But 
when I talked with one colleague he told me about 16550A (that is 
present nearly everywhere) that empty their TX FIFO, so I lowered it to 16.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
