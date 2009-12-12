From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 12 Dec 2009 18:11:43 +0000
Subject: [PATCH 1/4] mfd: mc13783: Take care of semantic inversion
	between read and write value of two bits in POWER_MISCELLANEUS
	register.
In-Reply-To: <1260636523.2054.28.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
Message-ID: <20091212181142.GC3092@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2009 at 05:48:43PM +0100, Alberto Panizzo wrote:
> MC13783_REGCTRL_PWGTnSPIEN controls the states of the corresponding
> PWGTn_DRV output.
> Reading 1 on the corresponding bit mean that the output is enabled
> Writing 1 on the corresponding bit disable that output!

> So, if not asked directly to modify those bits, write the inverted
> value.

Some comments in the code explaining what's going on wouild help a lot -
it's not going to be obvious to a reader why the code is doing this and
may well confuse them.
