From: carlo@caione.org (Carlo Caione)
Date: Wed, 23 Apr 2014 22:25:46 +0200
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <20140418151551.GZ12304@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
 <20140411161813.GF28800@sirena.org.uk>
 <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com>
 <20140418151551.GZ12304@sirena.org.uk>
Message-ID: <20140423202546.GA3890@nuc.fastwebnet.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 04:15:51PM +0100, Mark Brown wrote:
> On Thu, Apr 17, 2014 at 12:06:34PM +0200, Carlo Caione wrote:
> 
> > I'm fighting with a small issue when using the
> > regulator_bulk_register_supply_alias(). Problem is that when using the
> > .parent_supplies entry in the MFD driver, I hit the
> > 
> > WARN_ON(!list_empty(&dev->devres_head));
> > 
> > in linux/drivers/base/dd.c#L272, but, apart from the warning,
> > everything seems to work correctly.
> > A possible explanation I gave myself is that in the mfd_add_device()
> > we try to use the devm_* API when the regulator device is not bound to
> > the driver yet (I found some information here
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104442.html).
> > Is this the case?
> 
> Without knowing more about the case you're hitting it's hard to say - I
> do run a board which exercises the API for a MFD (with the arizona
> drivers) regularly and haven't noticed an issue so there must be
> something different about what you're trying to do.

I'm having a really hard time with this problem, so any hint is welcome
:) The small modification I'm using on top of the patches in this series
is here: http://bpaste.net/show/228330/

Unfortunately as I said I got this when booting:
http://bpaste.net/show/nUhUTzELT32v9HNPathL/

Thanks,

--
Carlo Caione
