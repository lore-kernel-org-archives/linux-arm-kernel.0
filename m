From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 13 Aug 2015 22:55:48 +0200
Subject: [PATCH V3 0/5] clk: support clocks which requires parent clock on
 during operation
In-Reply-To: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
References: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <CAGhQ9VyoepPsoLhuqFz397UnrM+n4SH0rp5Y3xfTQYvDXr=APw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On 28 July 2015 at 15:19, Dong Aisheng <aisheng.dong@freescale.com> wrote:
> This patch series adds support in clock framework for clocks which operations
> requires its parent clock is on.
>
> Such clock type is initially met on Freescale i.MX7D platform that all clocks
> operations, including enable/disable, rate change and re-parent, requires its
> parent clock on. No sure if any other SoC has the similar clock type.

Just noticed this patch set.

One of clock-controller blocks (CCU) on lpc18xx has a similar
requirement. The CCU is clock fanout block with gates and the gate
registers can not be accessed if the base (parent) clock for the gate
is not running. Doing so causes the cpu to wedge.

The workaround I have locally is to check in the is_enabled gate op if
the parent is running or not. This works fine, but I am all for a more
generic solution in the clk framework.

I'll see if I can find the time to test your patch set. Thanks for
working on this.


regards,
Joachim Eastwood
