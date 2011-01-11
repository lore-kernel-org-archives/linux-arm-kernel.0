From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 11 Jan 2011 22:35:42 +0800
Subject: Locking in the clk API
In-Reply-To: <20110111121816.GB774@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<201101111830.18597.jeremy.kerr@canonical.com>
	<20110111121816.GB774@linux-sh.org>
Message-ID: <201101112235.43061.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> Again, you are approaching it from the angle that an atomic clock is a
> special requirement rather than the default behaviour.

I'm not considering it a special requirement, but it's still a requirement 
(that the called function does not sleep).

The problem with the inverse logic (clk_enable/clk_enable_sleepable) is that 
now you've made the caller need to know what kind of clock it has, or might 
have one day.

 * For clk_enable/clk_enable_atomic, the decision is: is this call in an
   atomic context?

 * For clk_enable/clk_enable_sleepable, the decision is: might the clock code
   have given us a sleeping clock?

Note that it's much easier to guarantee correctness for the first than it is 
for the second.

Cheers,


Jeremy
