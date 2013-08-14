From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 01:08:18 -0700
Subject: [GIT PULL 00/19] Second round of Renesas ARM-based SoC DT
 updates for v3.12
In-Reply-To: <cover.1375838900.git.horms+renesas@verge.net.au>
References: <cover.1375838900.git.horms+renesas@verge.net.au>
Message-ID: <20130814080818.GG30577@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 01:28:09PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider this second round of Renesas ARM-based SoC DT updates for
> v3.12.
> 
> This pull-request is based on renesas-soc-for-v3.12 which I have
> previously sent a pull request-for. That is in turn based on
> renesas-dt-for-v3.12. So there is a semi-circular dependency,
> but it is not at all clear to me how this could be nicely avoided.

Best is to order it soc->dt instead of dt->soc, at least in this case. We tend
to sort the branches soc->boards->dt, so that fits.

There's also the alternative to base as much as possible on top of the old dt
branch, and only the bare minimum that depends on the soc branch in a separate
one (that we could even add on top of soc if truly needed). Note that it might
break down if you need yet another set of patches on top though.

For now I have added this to a next/dt2 branch to avoid the circular
dependency.


-Olof
