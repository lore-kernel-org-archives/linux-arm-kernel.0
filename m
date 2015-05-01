From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 01 May 2015 20:28:56 +0200
Subject: [PATCH v2 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <CANLsYkywp0o8YtjkFwfvEiAje-w2jCWbs_82SiD29xdirA_7vQ@mail.gmail.com>
References: <1430327795-10710-1-git-send-email-mathieu.poirier@linaro.org>
 <1430327795-10710-2-git-send-email-mathieu.poirier@linaro.org>
 <1430429397.2187.34.camel@x220>
 <CANLsYkywp0o8YtjkFwfvEiAje-w2jCWbs_82SiD29xdirA_7vQ@mail.gmail.com>
Message-ID: <1430504936.3928.13.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier schreef op vr 01-05-2015 om 08:39 [-0600]:
> On 30 April 2015 at 15:29, Paul Bolle <pebolle@tiscali.nl> wrote:
> > On Wed, 2015-04-29 at 11:16 -0600, Mathieu Poirier wrote:
> >> +#include <linux/module.h>
> >
> > Is this include needed?
> 
> It is needed for "module_param_named()".

I guess that it should suffice to include just
include/linux/moduleparam.h. (Note that [...]/module.h includes
[...]/moduleparam.h.)

> >> +module_amba_driver(etm4x_driver);
> >
> > In a message I sent a short while ago, I suggested that for built-in
> > only code this is equivalent to calling
> >     amba_driver_register(&etm4x_driver);
> >
> > from within a function marked with some sort of *initcall(). Please
> > double check.
> 
> Built-in as a module or not using "module_amba_driver()" deals with
> redundant code.

This is becoming yet another pet peeve: idempotent macros prefixed with
module_. driver_ would be a better prefix. But, in this case,
driver_amba_driver() is silly, amba_driver is used already, and
register_amba_driver() looks like amba_driver_register() way too much.

I fear that this pet peeve is going to hang around my place for quite
some time.

Thanks,


Paul Bolle
