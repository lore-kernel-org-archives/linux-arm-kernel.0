From: w@1wt.eu (Willy Tarreau)
Date: Mon, 8 Jul 2013 23:10:40 +0200
Subject: Handling ARM_ERRATA_364296 when CONFIG_SMP=y
In-Reply-To: <CAOMZO5AeqO_AmLp1=BwrMxOd4sh-omN6vG-R5f4EgpmzqCfhrg@mail.gmail.com>
References: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
 <20130708182212.GF3621@1wt.eu>
 <CAOMZO5AeqO_AmLp1=BwrMxOd4sh-omN6vG-R5f4EgpmzqCfhrg@mail.gmail.com>
Message-ID: <20130708211040.GG3621@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Jul 08, 2013 at 05:29:34PM -0300, Fabio Estevam wrote:
> Hi Willy,
> 
> On Mon, Jul 8, 2013 at 3:22 PM, Willy Tarreau <w@1wt.eu> wrote:
> 
> > Or maybe fix the config so that it does not force SMP on a CPU which
> > only exists as a single core ?
> 
> The original config is imx_v6_v7_defconfig and it selects by default
> both mx6 (quad core) and other single core CPUs.
> 
> That's the reason why CONFIG_SMP=y for this config by default.

OK, so if it's just a default, it's not really a problem, I understand
better now. So probably your solution to make the workaround not depend
on !SMP makes sense.

Regards,
Willy
