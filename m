From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 13 Dec 2011 20:44:53 -0800
Subject: [PATCH 3/7] HACK: omap: convert 44xx data to common struct clk
In-Reply-To: <alpine.DEB.2.00.1112132125200.12046@utopia.booyaka.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
 <1323835918-2371-4-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1112132125200.12046@utopia.booyaka.com>
Message-ID: <CAJOA=zM8hP=1BxcpDu-XMvt0KefRPwhP3m-+yC7Uta+Aozz8Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 8:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 13 Dec 2011, Mike Turquette wrote:
>
>> omap_clk_get_by_name must die.
>
> You do realize that it exists for a reason? ?That hardware clock names
> don't have anything to do with the Linux device model?

We have a tree structure of clks in the new common clk code, and a
list of clks in clkdev (which admittedly is meant to be a subset, but
in reality we register every OMAP clk with it), and then the omap clk
list which is only really used by omap_get_clk_by_name for hwmod and
some initialization stuff.  What I'd really like to do is get rid of
the OMAP clk code keeping track of it's clks in a separate list, which
seems quite wasteful.

Regards,
Mike
