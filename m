From: robherring2@gmail.com (Rob Herring)
Date: Tue, 15 May 2012 09:35:55 -0500
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515115511.75ece9c3@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch> <4FB22727.6090406@codethink.co.uk>
 <20120515115511.75ece9c3@skate>
Message-ID: <4FB269CB.4080804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 04:55 AM, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 10:51:35 +0100,
> Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :
> 
>>>> You'll find in this patch set the initial support for a new family
>>>> of ARMv7-compatible Marvell SoCs, that we have choosen to support
>>>> in the arch/arm/mach-armada/ directory.
>>
>> I went for the arch/arm/mach-mv-armadaxp as it kept the marvell socs
>> together (ignoring kirkwood and dove for the moment).
> 
> mach-mv-armadaxp would be a good name if we supported only the Armada
> XP SoC, but we also support the Armada 370 SoC within the same
> directory. This makes it easy to build a single binary kernel image
> that boots and runs on both SoCs.
> 

Directory location doesn't really have anything to do with what can be
in a single kernel binary. We will soon be building single images across
mach directories. With some hacks and limitations, Arnd has built (not
run) omap2+, u8500, imx and one other in a single kernel. If there's
overlap with dove or other platforms, then they should probably all be
combined into a single mach directory. One option would be make the new
mach directory somewhat generic and then later move dove or others into
the new directory.

Rob
