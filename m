From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 22 May 2013 16:23:17 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522141751.GF18614@n2100.arm.linux.org.uk>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521193803.GA20882@1wt.eu> <519C9779.1040104@gmail.com>
 <20130522134336.GE18614@n2100.arm.linux.org.uk>
 <20130522155218.1c2af492@skate>
 <20130522141751.GF18614@n2100.arm.linux.org.uk>
Message-ID: <519CD4D5.9060401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 04:17 PM, Russell King - ARM Linux wrote:
> The question which was asked was:
>
> 	What happens if you access a register at 0xd0xxxxxx when the
> 	registers are remapped to 0xf1xxxxxx?
>
> The answer which was given was:
>
> 	It hangs on XP / 370, but doesn't on Dove.
>
...
> What we need to know is: after the boot loader passes control to the
> kernel, and before _we_ start fiddling around with any clocks, is the
> region at 0xd0xxxxxx accessible without hanging the CPU?
>
> That's the point at which we'd want to probe for the remapped registers,
> so that's the point where the test access must be made - and with the
> system clocks in whatever state was left by the reset+boot loader.

Russell,

I tried both Armada 370 and Dove on a very minimal console-only barebox.
Poking the wrong addresses always hangs 370 while Dove happily returns
zero.

Sebastian
