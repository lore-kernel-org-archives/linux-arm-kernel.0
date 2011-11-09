From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Nov 2011 13:42:21 +0000
Subject: [PATCH] ARM: hw_breakpoint: don't fault when debug is not powered
In-Reply-To: <1320843602-12278-1-git-send-email-linus.walleij@stericsson.com>
References: <1320843602-12278-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111109134220.GE5825@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Nov 09, 2011 at 01:00:02PM +0000, Linus Walleij wrote:
> From: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> If the debug logic is not powered, the processor can unfortunately
> raise an undefined instruction exception on the instruction that
> we use to check if the debug logic is powered up or not.
> 
> Handle this with an undef hook, so that the kernel doesn't crash
> on boot on such setups.

Actually, I've done exactly this already! It got merged in the recent merge
window, so please take it for a spin.

Will
