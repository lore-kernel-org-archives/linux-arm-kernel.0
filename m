From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 23 Oct 2013 09:55:12 -0700
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <1382544332.8522.40.camel@shinybook.infradead.org>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <1382544332.8522.40.camel@shinybook.infradead.org>
Message-ID: <20131023165512.GB22394@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 05:05:32PM +0100, David Woodhouse wrote:
> On Wed, 2013-10-23 at 17:06 +0200, Thierry Reding wrote:
> > +       /* check if binding is experimental */
> > +       if (dev != device || drv != driver) {
> > +               pr_warn("of: device %s (%s) uses an experimental binding\n",
> > +                       np->name, np->full_name);
> > +
> 
> In the discussions earlier I think we decided that this should set a
> taint flag too. If you've built a kernel with CONFIG_OF_EXPERIMENTAL
> (which I think we were calling CONFIG_UNSTABLE_DT) then you have no
> expectation that it will boot tomorrow, although it might work with your
> DTB today.
> 
So to avoid tainting the kernel and clogging the kernel log I'll have
to remove all the "!" from the dt sources, or not use any "!" in the
dt bindings in the first place. Given that, not sure if anyone will
really use this mechanism. And CONFIG_OF_EXPERIMENTAL/CONFIG_UNSTABLE_DT
might have the same ultimate fate as CONFIG_EXPERIMENTAL.

Guenter
