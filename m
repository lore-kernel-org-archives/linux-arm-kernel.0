From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 24 Apr 2012 21:40:41 -0700
Subject: common clock framework
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A749F10CC@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A749F0DB6@SC-VEXCH2.marvell.com>
 <CAJOA=zPAy3AV6Dg9sE+fro1ZCmbxeCH8aeR5-YqffZphRkUQMQ@mail.gmail.com>
 <AAD1C6EB06EE3649B35B7E026785068D1A749F10CC@SC-VEXCH2.marvell.com>
Message-ID: <CAJOA=zPfnd97cfkcsA3vpBH5do_LKQzDTazT9FU6mgUKa25RrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 6:46 PM, Chao Xie <cxie4@marvell.com> wrote:
> Hi, Mike
> I have a question about the code layout.
> Why put the clock implementation for every SOC chip into drivers/clk/XXX/? Why not just put it into arch/arm/XXX?

Hi Chao,

Looping in the rest of LAKML since this these discussions are better
on the list.

The platforms converting over to common clk may put their clock code
in drivers/clk/ or leave it in arch/arm/.  For OMAP we're leaving the
code in arch/arm/mach-omap2/ for the time being due to the disruptive
nature of moving it into drivers/, though we might try to move it into
drivers some day.

There is no hard and fast rule forcing you to migrate your code into
drivers/clk/.  However doing so does expose your code to more eyeballs
and increases the likelihood that we can find common solutions to
problems shared by multiple SoCs/devices.

Regards,
Mike
