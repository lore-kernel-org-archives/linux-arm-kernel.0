From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Sep 2009 22:55:33 +0100
Subject: [PATCH 1/2] AB3100 regulator support v3
In-Reply-To: <63386a3d0909021437pe94b5a5m20a63fbad396cd13@mail.gmail.com>
References: <1251756258-23917-1-git-send-email-linus.walleij@stericsson.com>
	<20090902172438.GA1190@rakim.wolfsonmicro.main>
	<63386a3d0909021437pe94b5a5m20a63fbad396cd13@mail.gmail.com>
Message-ID: <20090902215533.GA18527@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 11:37:00PM +0200, Linus Walleij wrote:

> The sleep settings are driven by two HW lines, so a regulator
> can react by suspending the regulator on line A or B disjunct
> either (logical ||) or both (logical &&). (You don't alter that in
> runtime so no API has been developed here.)

OK, that's fine - it's setting things outside the normal API flow which
is all that I was asking.

> And I don't see any way for the core (set_machine_constraints)
> to set regulators to *off* by default if they happen to be on at
> boot.

That'd be a boot_off constraint if someone requires it.  So far nobody
has - there's not going to be many cases where it's appropriate to do
so, normally either you want to leave the supplies on for the device
driver that's taking control of the device or it does no harm to wait
till the end of init.
