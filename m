From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 2 Oct 2018 06:08:07 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
 <20181001175622.GT30658@n2100.armlinux.org.uk>
 <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
Message-ID: <CAHmME9q96VvYVkUUvq8CCihhs24AdJRRn_JMnJ42k2tyLK1WAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> On 1 October 2018 at 19:56, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> We could argue that the ARMv3 assembly files are now stable, so the
> chances of ldrh/strh being introduced is low, which would make this
> change tolerable, but the commit message needs to spell out that
> we lose this protection.

Actually I don't think that argument really holds too well. We very
well could introduce some new ARMv4 assembly -- an optimized crypto
routine, for example -- and it could use ldrh/strh. That isn't the
case now, but it might be the case later. For that reason, I suspect
the proper solution is just not building new cryptography assembly
that's written for ARMv4 in mind on CPU_32v3 systems. This way there's
never a mismatch of expectations.

Jason
