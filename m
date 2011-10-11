From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Oct 2011 12:42:12 -0700
Subject: [PATCH] arm/tegra: Harmony: Configure PMC for low-level interrupts
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173BE19AC3@HQMAIL01.nvidia.com>
References: <1316643040-7998-1-git-send-email-swarren@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE19AC3@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMissLSUVnZx7JwkPz7V8HhtNmdd+La7WdNqpQK3BJHhvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 10:03 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Stephen Warren wrote at Wednesday, September 21, 2011 4:11 PM:
>> Without this, the PMC continually detects an interrupt when the PMU_IRQ
>> line is high, causing the tps6686x IRQ handler thread to hog an entire
>> CPU.
>>
>> This change was originally written by Wei Ni <wni@nvidia.com> for Seaboard
>> in the ChromeOS kernel.
>>
>> Long-term, this should probably be moved into some kind of PMU driver,
>> or perhaps integrated into the GPIO/IRQ/pinmux system?
>
> Olof, is this change OK for inclusion? Or, should we create some kind
> of PMU driver and interrupt controller to solve this?

I'm OK with it going in now as it is, but as we move to more things to
device-tree, having a common piece of code that does it based on
properties there would make sense. Today I think every single board
needs it.

I'll pick up the patch and push it out later today.


-Olof
