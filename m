From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Wed, 20 Dec 2017 10:22:19 +0530
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <4e80e47a-d7b4-c09c-fe88-a7dff6522038@arm.com>
References: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
 <20171219112954.GA14910@afzalpc>
 <4e80e47a-d7b4-c09c-fe88-a7dff6522038@arm.com>
Message-ID: <20171220045219.GA6416@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 19, 2017 at 02:44:01PM +0000, Vladimir Murzin wrote:

> > Was the issue observed on Cortex-R ?, and was it occuring with
> > CONFIG_CPU_HIGH_VECTOR enabled or disabled ?
> 
> I caught it when was trying to setup VBAR and after code inspection I
> noticed that setting of Hivecs were changed as well.

Thinking again about this, should the Hivecs setting on secondary
CPU's be done (till a requirement comes) ?

ARM ARM deprecates using Hivecs setting on ARMv7-R, so this issue
might not be hit in practice for R class. While pre-ARMv7, lack of
Hivecs setting for secondaries, it seems can affect only ARMv6k
(multi-processing support added here ?) and i am making a guess that
even if there are ARMv6k with more than one core available, they might
not yet have run with MMU disabled to hit this case, probably the
reason no one has reported issue for long.

Perhaps, we can avoid configuring Hivecs for secondaries until some
one needs it ?

afzal
