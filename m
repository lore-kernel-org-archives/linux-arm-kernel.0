From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 19 Jun 2018 12:10:18 +0100
Subject: [Dev] [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <20180618074556.6944-1-linus.walleij@linaro.org>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
Message-ID: <20180619111018.r3m35g4ei6625pqz@holly.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 09:45:51AM +0200, Linus Walleij wrote:
> This is a proposal for how to handle the non-discoverable
> 96boards plug-in expansion boards called "mezzanines" in the
> Linux kernel. It is a working RFC series meant for discussion
> at the moment.
> 
> The RFC was done on the brand new Ultra96 board from Xilinx
> with a Secure96 mezzanine expansion board. The main part
> is in patch 4, the rest is enabling and examples.
> 
> The code can be obtained from here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=ultra96
> 
> You can for example probably augment the DTS file for any
> upstream-supported 96board and get the Secure96 going with
> it with minor efforts.

Like other commenters I'm rather like using C to solve this, and your
comments Big Upfront Design are good backup in term of convincing me.

 
> TODO:
> 
> - Proper device tree bindings for the connector, for now
>   look at the example.
> 
> - Discuss whether to actually do this or just take it all and
>   flush it down the drain because the community doesn't like
>   it. I'm not one of those especially infatuated with my own code,
>   I always stay by the old programming project management mantra
>   to calculate to make one version and throw it away as stepping
>   stone to a good final design.
> 
> - Placement: putting this in drivers/bus is just an example.
>   drivers/platform/96boards-mezzanines is fine too, maybe better?
> 
> - I am especially curious about input from Andy and Mika from
>   the Intel/ACPI camp on what they have seen for non-discoverable
>   plug-in boards. Does this problem even exist in the Intel
>   world, or not...

I'm also interested in the "what about ACPI" question?

Using C makes describing a board in ACPI fairly easy. AFAICT allocating
IDs to a board rather than its included components is fairly natural for
ACPI.

However I'm too ignorant to be able to figure out if the expansion
connector itself could/should be described in the tables (e.g. if
connector is a bus and the board is[1] a device, could the bus driver
be instantiated in a reasonable way).


Daniel.


[1] ... or becomes a device, based on feedback in this thread ;-)
