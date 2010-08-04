From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Aug 2010 14:25:42 +0800
Subject: [PATCH] PXA: Colibri320: Add M41T00 RTC support
In-Reply-To: <20100731092206.GC23886@n2100.arm.linux.org.uk>
References: <1280543453-28237-1-git-send-email-marek.vasut@gmail.com>
	<201007310926.03292.pieterg@gmx.com>
	<201007310933.05611.marek.vasut@gmail.com>
	<20100731090554.GX17833@buzzloop.caiaq.de>
	<20100731092206.GC23886@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikvuwyfWwTu3vjvUM2zML4paqtY3+g3OhReL9KL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 5:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jul 31, 2010 at 11:05:54AM +0200, Daniel Mack wrote:
>> Hmm, GPIOs for peripherals that are assembled on the module itself can
>> safely be configured unconditionally as it is impossible to use them for
>> anything else. For GPIOs that are allocted by a specific base board,
>> things are different though, especially for the the Colibri eval board
>> with it hundreds of jumpers on it. It's a convenience feature to have
>> them free for general purpose use just by disabling a certain config
>> directive.
>
> It would probably make sense for their to be a primary table which at
> least ensures that all pins are setup to safe default values. ?You
> really don't want the unconnected pins left floating, especially if
> they come out to some vulnerable connector or unconnected jumper pin.
>
> I'd suggest they're configured as inputs but with a pull-up or pull-down,
> not forgetting to consider the low power mode pull setting as well.
>

Yeah, that's also my opinion. So for those pins which can be connected
to different usages (e.g. to two or more different expansion boards), I'd
like to have the baseboard code to configure them safely (e.g. inputs with
pull as Russell suggested), and perform another mfp config in the
expansion board code.
