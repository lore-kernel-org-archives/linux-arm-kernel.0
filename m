From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 6 Dec 2011 11:11:05 +0000
Subject: [PATCH] ARM: make head.S register assignments more convenient
In-Reply-To: <alpine.LFD.2.02.1112051528200.2357@xanadu.home>
References: <alpine.LFD.2.02.1112051528200.2357@xanadu.home>
Message-ID: <20111206111105.GA2270@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 03:31:43PM -0500, Nicolas Pitre wrote:
> 
> The r1 (machine ID) and r2 (boot data pointer) values are getting
> in the way of standard procedure calls as those registers are normally
> clobbered by function calls.  This is especially obnoxious when using
> the printascii et cie debugging routines..  This non-standard register
> allocation is even leaking into code far away from head.S i.e. the *_setup
> routines in mm/proc-*.S.
> 
> Move the machine ID / boot data pointer  to r6 and r7 respectively, and
> adjust the surrounding/affected code accordingly.
> 
> Minor fixes to some comments are also included.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/kernel/head-common.S |  101 +++++++++---------
>  arch/arm/kernel/head-nommu.S  |    4 +-
>  arch/arm/kernel/head.S        |  207 ++++++++++++++++++-----------------
>  arch/arm/mm/proc-arm1020.S    |    8 +-
>  arch/arm/mm/proc-arm1020e.S   |    8 +-
>  arch/arm/mm/proc-arm1022.S    |    8 +-
>  arch/arm/mm/proc-arm1026.S    |    8 +-
>  arch/arm/mm/proc-arm720.S     |   16 ++--
>  arch/arm/mm/proc-arm920.S     |    8 +-
>  arch/arm/mm/proc-arm922.S     |    8 +-
>  arch/arm/mm/proc-arm925.S     |    8 +-
>  arch/arm/mm/proc-arm926.S     |    6 +-
>  arch/arm/mm/proc-feroceon.S   |    8 +-
>  arch/arm/mm/proc-mohawk.S     |    8 +-
>  arch/arm/mm/proc-sa110.S      |   16 ++--
>  arch/arm/mm/proc-sa1100.S     |    8 +-
>  arch/arm/mm/proc-v6.S         |   22 ++--
>  arch/arm/mm/proc-v7.S         |  130 +++++++++++-----------
>  arch/arm/mm/proc-xsc3.S       |   10 +-
>  arch/arm/mm/proc-xscale.S     |    8 +-
>  20 files changed, 302 insertions(+), 298 deletions(-)

Is it also worth changing the other proc-*.S setup rountines to be PCS
compliant too?  This would clean up the calling convention further, and
help avoid future sutprises.

Cheers
---Dave
