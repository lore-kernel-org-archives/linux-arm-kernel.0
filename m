From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Feb 2014 17:11:45 +0000
Subject: [PATCH v2 0/9] ARM: multi-platform kconfig cleanup and mach-virt
 removal
In-Reply-To: <1726732.KPDAFqxz2K@wuerfel>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <20140212134655.GC29132@mudshark.cambridge.arm.com>
 <CAL_JsqJkCXSFJZzRBRTrKh16PoBjvF95uKJbZAic-pk3htf_jg@mail.gmail.com>
 <1726732.KPDAFqxz2K@wuerfel>
Message-ID: <52FBAB51.4050401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/14 16:53, Arnd Bergmann wrote:
> 
> On the topic of V6, we don't support CPU_V6T2 at all, though I assume that
> there is an ARM1156 core tile for integrator and realview, and we support
> running the V6/V6K parts with MMU turned off. Would all revisions of ARM1156
> work with CPU_V6K and !MMU?

CPU_V6 and !MMU should work. V6K might, but that requires close
inspection (WFE, SEV shouldn't be used in UP context)...

Full disclosure: I happen to have a *brand new*, freshly unwrapped
ARM1156 core tile for a Versatile EB. All it requires is a victim with
time on their hand...

	M.
-- 
Jazz is not dead. It just smells funny...
