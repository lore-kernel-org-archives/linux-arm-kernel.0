From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Fri, 11 Apr 2014 08:12:02 +0200
Subject: [PATCH] Route keyboard LEDs through the generic LEDs layer.
In-Reply-To: <20140408233306.GJ27820@type.youpi.perso.aquilenet.fr>
References: <20140331122323.GC6044@type.bordeaux.inria.fr>
 <20140407021015.GA8518@core.coreip.homeip.net>
 <20140407075423.GZ7179@type.wlan.youpi.perso.aquilenet.fr>
 <20140408083940.GA22855@core.coreip.homeip.net>
 <20140408233306.GJ27820@type.youpi.perso.aquilenet.fr>
Message-ID: <20140411061202.GA8321@type>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm sorry this went out with a few mistakes.

Samuel Thibault, le Wed 09 Apr 2014 01:33:06 +0200, a ?crit :
> Dmitry Torokhov, le Tue 08 Apr 2014 01:39:40 -0700, a ?crit :
> > It is not about the VT, I am talking about pure input core. If I
> > repurpose CapsLock LED for my WiFi indicator I do not want to go into
> > other programs and teach them that they should stay away from trying to
> > control this LED.
> 
> Err, but even without talking about repurposing Capslock LED for WiFi...
> How is managed the conflict between the normal capslock behavior and
> other programs' action on the underlying input device?  I don't think
> this patch does not introduce the problem.

I of course meant "I don't think this patch introduces the problem".

> How to decide which one to prioritize?
> 
> Is it just because console-setup happens to repurpose the capslock LED
> key that applications should suddenly not have capslock LED control
> at all?  That's contradictory with the use case you have given.

Oops, not the use case you have given, but a typical use-case of wanting
to use a program which does nice things with the capslock LED, and then
having to teach console-setup not to repurpose the capslock LED.

> That
> leads me into believing that we should not try to push a hard rule, and
> just let the user manage what accesses it.  We could indeed make the VT
> always take priority, but then that would probably break some existing
> applications.

Such as the example above, with the capslock LED.

Samuel
