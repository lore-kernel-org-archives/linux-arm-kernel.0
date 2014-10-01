From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 01 Oct 2014 09:51:06 -0700
Subject: [PATCH v2 0/3] ARM: rk3288 : Add PM Domain support
In-Reply-To: <1411899774-8484-1-git-send-email-jinkun.hong@rock-chips.com>
 (jinkun hong's message of "Sun, 28 Sep 2014 03:22:51 -0700")
References: <1411899774-8484-1-git-send-email-jinkun.hong@rock-chips.com>
Message-ID: <7hoatvvimd.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Geert, Ulf

"jinkun.hong" <jinkun.hong@rock-chips.com> writes:

> From: "jinkun.hong" <jinkun.hong@rock-chips.com>
>
> Use PM Domain framework to manage the clock.

Which clock?  This changelog needs a more thorough description.  Also,
with this series alone, it's not clear how the power-domain transitions
ever happen, since I don't see any devices hooked up to your power
domains, or do I see your platform using runtime PM.  In order for this
to be reviewed properely, it's important for reviewers to be able to see
how this PM domain support will be used.

Also, remember that the DT is supposed to reflect the hardware, not the
design choices of linux drivers.  Because of that, it's a little
surprising to see clocks as properties of a power domain because clocks
are usually properties of devices.

I suggest you have a look at the sh-mobile implementation of DT-based
power domains by Geert[1], which shows how he's hooking up device clocks.

Kevin

[1] http://marc.info/?l=linux-pm&m=141166256415448&w=2
