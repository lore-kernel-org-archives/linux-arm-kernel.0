From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 22 May 2013 16:17:18 +0200
Subject: [PATCH 9/9] arm: mvebu: switch internal register address at
 runtime if needed
In-Reply-To: <20130522140444.GK2824@lunn.ch>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522152700.4dab10a1@skate> <20130522140444.GK2824@lunn.ch>
Message-ID: <519CD36E.1090900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 04:04 PM, Andrew Lunn wrote:
> It might be worth cross posting both u-boot and barebox lists, since
> they are somewhat involved as well. Are there any other boot loaders
> used on 370 and XP.

barebox is not neccessary, Thomas and I just merged SoC init to always
map on KW, Dove, and A370/XP. It is in a very early stage (console-only)
and will take some time to actually boot linux. And we have SoC
specific init that can set CP15 there.

> How does this effect dove? It will get compiled into the same multi
> arch kernel as 370/XP. I'm thinking about
> arch/arm/include/debug/mvebu.S which might be shared. Dove is not
> going to have this bit set. Kirkwood could also share this code, now
> that the serial ports are all in the same location.

Dove is difficult because u-boot always remaps and never sets the bit
in CP15 _but_ doesn't hang on writing wrong addresses. So remap by
writing to 0xd0.. will do no harm.

Sebastian
