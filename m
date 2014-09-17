From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Sep 2014 13:27:37 -0500
Subject: [PATCH] clk: prevent erronous parsing of children during rate
 change
In-Reply-To: <20140903192203.11368.5520@quantum>
References: <1408628866-32351-1-git-send-email-t-kristo@ti.com>
 <20140903192203.11368.5520@quantum>
Message-ID: <20140917182737.GF8140@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Sep 03, 2014 at 12:22:03PM -0700, Mike Turquette wrote:
> Quoting Tero Kristo (2014-08-21 06:47:45)
> > In some cases, clocks can switch their parent with clk_set_rate, for
> > example clk_mux can do this in some cases. Current implementation of
> > clk_change_rate uses un-safe list iteration on the clock children, which
> > will cause wrong clocks to be parsed in case any of the clock children
> > change their parents during the change rate operation. Fixed by using
> > the safe list iterator instead.
> > 
> > The problem was detected due to some divide by zero errors generated
> > by clock init on dra7-evm board, see discussion under
> > http://article.gmane.org/gmane.linux.ports.arm.kernel/349180 for details.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > To: Mike Turquette <mturquette@linaro.org>
> > Reported-by: Nishanth Menon <nm@ti.com>
> 
> Applied to clk-fixes.

v3.17-rc5 and today's next still exhibit the same bug. Any chance we can
this fix into v3.17-final ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140917/01cf6821/attachment.sig>
