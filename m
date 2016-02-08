From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 08 Feb 2016 10:58:55 +0100
Subject: [PATCH v3 1/3] reset: Make [of_]reset_control_get[_foo]
 functions wrappers
In-Reply-To: <56B4EA46.7060905@redhat.com>
References: <1453918516-3078-1-git-send-email-hdegoede@redhat.com>
 <1453918516-3078-2-git-send-email-hdegoede@redhat.com>
 <1454604866.3356.78.camel@pengutronix.de> <56B4EA46.7060905@redhat.com>
Message-ID: <1454925535.3466.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 05.02.2016, 19:30 +0100 schrieb Hans de Goede:
[...]
> > Even though we are device tree only at this point, I'd prefer to keep an
> > exported function that takes a struct device argument, for example:
> >
> > 	return __reset_control_get(dev, id, 0);
> 
> I don't really see a reason to do this, this is not userspace abi or some-such
> we can always later re-introduce an exported function which takes a device
> argument. But if you insist, you're the boss :)

s/boss/janitor/ more like

> Let me know if you really
> want me to make this change for the next version, and I'll add it to v4 of this
> set.

Leave it as is. I have a patch to add it back, and yes it looks a bit
superfluous on its own. I'll add apply that only once its actually
needed.

regards
Philipp
