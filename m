From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Nov 2015 07:06:03 -0800
Subject: Minimal support for dm814x
In-Reply-To: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
Message-ID: <20151109150602.GR3199@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Delio Brignoli <dbrignoli@audioscience.com> [151105 05:10]:
> Hello Tony,
> 
> We use dm814x in some of our products with a kernel based on version 2.6.37 modified by TI and are considering moving to a current kernel version. I recently saw this <http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348444.html> and I?d like to try getting our board to boot as a first step and then take it from there.
> We aim at eventually having remoteproc working (at least for the DSP) and to port fixes/features we added to our 2.6.37 based tree [2].

OK great. Once you post some patches, I'm sure other people will start helping
with the effort too.

> The temporary testing branch [1] mentioned in your original message is not longer available, does that mean I can just use the master branch of <https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git> for my tests? Which toolchain did you use to build your test kernel for the hp t410?

It's now merged to mainline v4.3, so whatever is the current latest tagged
mainline kernel release (v4.3 currently) is the one to use from now on
natually :) The PLL support is still missing, so it relies on the bootloader
configured PLL values for now. I'm hoping to post PLL support patches over
next few weeks and then we can have that and more devices working for v4.5.

> I wonder if there is anyone on this list already working on getting dm814x fully working or interested in cooperating towards this goal.

Yes for sure. I've also addes linux-omap list to Cc.

Regards,

Tony

> [1] <https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=tmp-testing-dm814x-2015-06-03>
> [2] <https://github.com/audioscience/linux-omap3/tree/asi1230-upstream-tracking>
