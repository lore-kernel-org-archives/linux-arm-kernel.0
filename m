From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 24 Dec 2013 14:45:49 +0100
Subject: [PATCH v3 04/12] clk: Add regmap core helpers for
 enable/disable/is_enabled
In-Reply-To: <20131219202419.GS8064@book.gsilab.sittig.org>
References: <1381909214-12693-1-git-send-email-sboyd@codeaurora.org>
 <1381909214-12693-5-git-send-email-sboyd@codeaurora.org>
 <20131219045050.23538.94293@quantum>
 <20131219202419.GS8064@book.gsilab.sittig.org>
Message-ID: <20131224134549.GF8064@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 21:24 +0100, Gerhard Sittig wrote:
> 
> Wasn't the idea to extend the set of register accessor routines
> in <linux/clk-provider.h> such that memory mapped I/O as well as
> regmap style becomes possible?  This is what I understood from
> past iterations of discussing this approach.

Just FYI and to have the pointer in some archive:  Had a look at
recent threads because it appears that several pending changes
have similar needs to adjust the kind of hardware access, while
sharing common code to handle the actual clock item logic would
be desirable.

Please check "[PATCHv12 00/49] ARM: TI SoC clock DT conversion"
from Tero Kristo as of 2013-12-20, which "in bypassing"
introduces low level ops for register access (patches 06 and
following).  I suggested to separate this hardware access aspect
out of the "TI SoC clock" series (almost missed the fact that it
changes behaviour in common code), and to add regmap support or
at least allow to do regmap on top of the ll_ops infrastructure.

With the proposed generic approach all of us should be happy.
The vast amount of ARM code should not experience any change, the
queued PowerPC support can keep working, new TI SoC clocks can
get implemented, Steven you can get regmap access, and more
platforms may use the common code even if readl()/writel() won't
fit them.  Let's followup in Tero's v12 feedback thread to make
that happen.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
