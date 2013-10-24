From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 24 Oct 2013 15:00:55 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131024122346.GD11296@ulmo.nvidia.com>
References: <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef> <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <20131024122346.GD11296@ulmo.nvidia.com>
Message-ID: <1382619655.6040.52.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-10-24 at 14:23 +0200, Thierry Reding wrote:

> To me it sounds more like the sensible default would be to continue to
> run with PIO support if the optional properties needed for DMA support
> are not present.

huge leap backward

 - need to maintain & test two completely different code paths (might as
well fork the driver)

 - we can no longer claim: "upgrade to mainline, you get all new stuff
for free"

Today I can 'just' upgrade my kernel and get all improvements in
networking stack, fs scalability, ... Before DT, hardware support &
drivers improvement were part of that package, now we are proposing they
won't.

> Determining default values for the properties pretty much defeats the
> purpose of putting them in the DT in the first place, doesn't it?

my point

before DT scenario for my hw crypto driver example: 
  - edit socX.h to add the missing #define HW_CRYPTO_INTERRUPT
  - edit platform data to add IRQ resource
  - change driver code to use DMA
  - single bisectable merge
  - anyone with socX benefits by just upgrading kernel

DTS files are sometimes describing SOCs hardware properties that cannot
be changed in any way, these values would better be left in soc-foo.h
(where they were before).

-- 
Maxime
