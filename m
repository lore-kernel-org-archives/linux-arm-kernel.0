From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 22:05:08 +0100
Subject: [PATCH v4 3/6] ARM: at91/dt: define sama5d3 clocks
In-Reply-To: <52A5F79D.9070408@overkiz.com>
References: <1385650171-8756-1-git-send-email-b.brezillon@overkiz.com>
 <201312091748.58386.arnd@arndb.de> <52A5F79D.9070408@overkiz.com>
Message-ID: <201312092205.08933.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, boris brezillon wrote:
> Are you talking about drivers or clk binding documentation ?
> In either cases they're not defined :-), but I'd like to know which 
> file(s) I should update.

I mean bindings for the devices using these clocks. Each of them should
list among its properties something like

|Mandatory properties:
|  clocks:	One phandle and clock specifier for xxxx
|  clock-names:	The name of this clock, must be "xxxx"

Of course if we decide to make it an anonymous clock, we still need to
document the fact that the clock is required.

> I'd rather not change the static clock lookup tables, but if you prefer this
> approach (and Nicolas agrees), I'll propose a series modifying the drivers
> and clk lookup table.
> 
> Whatever solution is choosen, I guess I'll have to update the drivers dt
> binding documentation anyway ;-).

Ok. FWIW, I think the best way to stage the clock updates (if the decision
is to make them anonymous) would be to duplicate all the clocks in question
in a first patch, and then submit changes for each driver to the respective
subsystem maintainers with a patch based on the first changeset.

Once all the drivers are converted (i.e. the following merge window), we can
remove the obsolete entries.

	Arnd
