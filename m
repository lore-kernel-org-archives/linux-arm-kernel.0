From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2011 16:28:38 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <BANLkTim5umALqafjA2e88UCLzMp9LQu3_Q@mail.gmail.com>
References: <201104212129.17013.arnd@arndb.de>
	<20110421130930.4be9e9e1@jbarnes-desktop>
	<BANLkTim5umALqafjA2e88UCLzMp9LQu3_Q@mail.gmail.com>
Message-ID: <201104261628.38734.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Zach Pfeffer wrote:

> I agree with Jesse that the separation of mapping from allocation is
> central to the current usage models. I realize most people didn't like
> VCMM, but it provided an abstraction for this - if software can handle
> the multiple mapper approach in a rational way across ARM than we can
> solve a lot of problems with all the map and unmap current solutions
> and we don't have to hack in coherency.
 
Any solution we come up with needs to work on only across ARM, but
also across other architectures. Fortunately, most have less weird
constraints, for instance some architecture have no concept of uncached
mappings (and don't need them), or there might be DMA ordering settings
that we have not yet seen on ARM.

	Arnd
