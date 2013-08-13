From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 14 Aug 2013 07:03:59 +1000
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <520A536C.3030600@arm.com>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com>
Message-ID: <1376427839.4255.10.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-13 at 16:40 +0100, Sudeep KarkadaNagesha wrote:
> There seems to be conflict in the new function "of_get_cpu_node" added.
> PowerPC also defines the same function name. Further microblaze and
> openrisc declares it(can be removed) but doesn't define it.
> To fix this:
> 1. I can rename the newly added function to something different like
>    `of_get_cpunode` or
> 2. If of_* namespace should be used by only OF/FDT and not by any
>    architecture specific code, then the arch specific version can be
>    renamed to some thing like arch_of_get_cpu_node.
>    Also most of the calls to arch specific function can be moved to
>    generic code.
> 
> Let me know your thoughts.

What is your new function about ? Does it perform the same job as the
one in powerpc ? If yes, make sure you have the same signature and
either copy the powerpc one over to a generic place or make the generic
one weak if you don't want the powerpc thread counting logic.

Cheers,
Ben.
