From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jun 2017 11:19:13 +0200
Subject: [PATCH] arm: aspeed: Add Aspeed board file with clocksource
 devicetree fixup
In-Reply-To: <20170609073037.21871-1-andrew@aj.id.au>
References: <CAK8P3a0EaqwmAMRWn--29e4Kt6zJA9kHL2dpj=7Uabn5hANxOA@mail.gmail.com>
 <20170609073037.21871-1-andrew@aj.id.au>
Message-ID: <CAK8P3a23XpDQhnM=j8FBS8NGck2ZfaAotVo191NEOttP2GDCYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 9:30 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> Add the clock-names property in init_timer() to work-around Aspeed
> devicetrees from times prior to merging the Moxart/Aspeed and Faraday
> drivers.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Well, here's an implementation I knocked up. It's a fair chunk of code for
> marginal benefit. Joel is against it.
>
> At least it's something to debate.
>
> Tested under QEMU for both AST2400 and AST2500 SoCs.

Right, I think having the one-line fixup in the driver makes way more sense
here, and that is what we usually do, but we could do this if Daniel has good
reasons to keep the driver free of backwards-compatibility support.

It also depends a bit on how common the old binding version already
is, and if anyone is shipping systems with that.

       Arnd
