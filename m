From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 06 Oct 2015 12:44:54 +0300
Subject: [PATCH 0/2] ARM: EXYNOS: Allow to use architected timer
In-Reply-To: <5008072.V9UdTVvpUS@wuerfel>
References: <cover.1444119342.git.p.fedin@samsung.com>
 <6613638.q5qyQZxXy7@wuerfel> <00d801d10014$e6d994a0$b48cbde0$@samsung.com>
 <5008072.V9UdTVvpUS@wuerfel>
Message-ID: <00e901d1001b$a7fae610$f7f0b230$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> My feeling is that is shouldn't be keyed off the presence of the device in DT
> though. Maybe we can find a way that allows you to put the device into DT
> but not have it used by default unless the user explicitly enables it, e.g. though
> a kernel command line option like "force_broken_archtimer"?

 For this purpose we have status = "disabled" in the device tree. We can add CP15 timer node and
disable it. If the user needs it, the bootloader could just change "disabled" to "ok", and it's
done.
 The only problem here would be that CP15 timer on Exynos is actually tied to MCT. We need to enable
MCT, otherwise clocks don't tick. That's why i decided to make CP15 timer a subnode.
 My current patch lacks "status" property check, i could add it if you agree with this approach.

> Or maybe we could find a way to keep using MCT in the host but use the
> arch timer in the guest only?

 That's an interesting question, but, perhaps, it would require more changes to the code, and KVM
maintainers don't like these things, calling them "broken non-compliant hardware". So, i guess, we
could move from simple things to more complex ones.

> For all I can tell, nobody every /saw/ the problem, we just know that it
> hasn't passed verification (or something like that) and you shouldn't
> use it in production.

 Yes, and i agreed that this should be an option, not the default. 

 P.S. I cc'ed to linux-samsung-soc, but i'm not subscribed. Will it reach there?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
