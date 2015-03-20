From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 20 Mar 2015 16:20:59 +0000
Subject: [PATCH] ARM: trusted_foundations: Maintain CPU endianness
In-Reply-To: <550C4106.4090801@gmail.com>
References: <1426865807-22981-1-git-send-email-digetx@gmail.com>
 <550C4106.4090801@gmail.com>
Message-ID: <20150320162059.GD4725@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 06:47:18PM +0300, Dmitry Osipenko wrote:
> This patch not tested. I assume that firmware save/restore cp15
> context, i.e. it doesn't require switching to LE before smc call and
> restore endianness after.

That assumption should be valid.

However, I think this patch must be tested before assuming it is
correct.  If the arguments were passed in memory then there might
force LE order for that data block, but there should not be a need for
this if the values are in registers.

Cheers
---Dave
