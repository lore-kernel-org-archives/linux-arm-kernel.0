From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Nov 2011 18:06:51 +0000
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <20111123165903.GF31337@atomide.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
 <20111122191347.GB4844@kroah.com> <20111123165903.GF31337@atomide.com>
Message-ID: <20111123180651.GB19739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 08:59:04AM -0800, Tony Lindgren wrote:
> ..let's plan on getting rid of the early usage of clocks instead so
> you don't have the issue of deferring stuff.

No - we have too many platforms already using them early to do a change
like this - and to do such a change will force them to invent some other
way.  That's just stupid.

Keep the clk API as a fundamental thing which should be initialized early
so we don't have to invent new clk APIs to get around its unavailability.
