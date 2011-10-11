From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Oct 2011 19:48:21 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111011150915.GE23188@mudshark.cambridge.arm.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<201110101320.24457.arnd@arndb.de>
	<20111010133246.GG2451@mudshark.cambridge.arm.com>
	<201110111533.50768.arnd@arndb.de>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
Message-ID: <20111011184821.GA11839@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just to follow up on this...

On Tue, Oct 11, 2011 at 04:09:15PM +0100, Will Deacon wrote:
> For the cpu-mapping, I depend on:
> 
> ARM: 7011/1: Add ARM cpu topology definition
> ARM: 7060/1: smp: populate logical CPU mapping during boot
> ARM: 7061/1: gic: convert logical CPU numbers into physical numbers
> 
> which I can only see in Russell's for-next branch.
> 
> For the debug-ll stuff, I depend on:
> 
> ARM: 7072/1: debug: use kconfig choice for selecting DEBUG_LL UART
> 
> and conflict with:
> 
> ARM: 7097/1: debug: Move DEBUG_ICEDCC into the DEBUG_LL choice
> ARM: 7096/1: debug: Add UART1 config choices
> ARM: 7116/1: debug: provide dummy default option for DEBUG_LL UART choice
> ARM: 7073/1: debug: augment DEBUG_LL Kconfig help to clarify behaviour

I've stuck a debug-ll branch and a cpu-mapping branch here:

git://github.com/wdeacon/linux-wd.git

(I finally gave up with my old broken git server!)

These branches are based against -rc9 and I've cherry-picked the
dependencies from Russell's for-next branch. I'm not sure that's good for
anything, but it at least helps to show what's already in Russell's tree
and what's currently outstanding.

Will
