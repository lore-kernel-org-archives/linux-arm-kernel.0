From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Fri, 2 Jan 2015 21:11:17 +0100
Subject: [PATCHv5 0/2] INPUT: Route keyboard LEDs through the generic
 LEDs layer
In-Reply-To: <20150102195350.GB27538@amd>
References: <20141226232116.GA5069@type>
 <20150102195350.GB27538@amd>
Message-ID: <20150102201117.GD25336@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek, le Fri 02 Jan 2015 20:53:51 +0100, a ?crit :
> input4::capsl/trigger was none by default, that can't be right, right?

Indeed. And I don't see how it can be that way, since the input4::capsl
LED and the input4-capsl trigger get initialized at the same time in
input_led_connect... (and the order does not matter since both will
try to connect to the other on registration).

> I tried putting kbd-capslock and input4-capsl there, but that did not
> seem to help.

That should have.

> It works with heartbeat trigger, but not with input4-numl
> trigger.

It should have worked with input4-numl too.

> vt::capsl/brightness controls capslock led, even when
> input4-capsl/trigger is set to input4-numl.

It shouldn't.

> Confused,

I guess I'm even more.  I had tested everything that you have described,
without any issue, on both an internal laptop keyboard and an external
USB keyboard, and have tested again just now, with the same success.

Which hardware setup do you have, more precisely?

Samuel
