From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 4 Aug 2010 09:19:38 +0100
Subject: [alsa-devel] [PATCH 1/2] ARM: S5PV210: Add audio support to Aquila
In-Reply-To: <4C5905D3.8090703@samsung.com>
References: <4C4F9E4C.7000001@samsung.com>
	<20100729173825.GE24781@opensource.wolfsonmicro.com>
	<4C527C11.5090409@samsung.com>
	<20100803085929.GC25306@rakim.wolfsonmicro.main>
	<4C5905D3.8090703@samsung.com>
Message-ID: <20100804081938.GD22446@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 04, 2010 at 03:16:51PM +0900, Chanwoo Choi wrote:
> Mark Brown wrote:

> > OK, good - the fact that the connection wasn't being made with the PMIC
> > was my main point here.

> Did you read writed mail about consumer supply of WM8994 by MyungJoo Ham?

I saw it, yes.

> He is in charge of PMIC and Power Management on Aquila board.

> MyungJoo Ham is wrote : 
> This aquila_buck3_data.constraints would be better have ".always_on =
> 1" entry as this buck3 is required to be turned on at all times in
> Aquila boards (even when the system is in suspend-to-mem state). This
> is required especially when there are many devices physically attached
> to Buck3 and some of they did not "register" as consumers to Buck3.
> Buck3 might be turned off by those who are registered while
> "unregistered" are still active.

> Can you tell me your opinion about the review by MyungJoo Ham?
> I will respect your response.

I think his comments are sensible.  The constraints should always try to
reflect the actual constraints of the system as closely as possible.
