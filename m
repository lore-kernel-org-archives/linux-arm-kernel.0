From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 03 Nov 2010 10:57:34 -0700
Subject: [PATCHv2 1/3] ARM: Translate delay.S into (mostly) C
In-Reply-To: <1288300770-18350-2-git-send-email-sboyd@codeaurora.org>
References: <1288300770-18350-1-git-send-email-sboyd@codeaurora.org>
	<1288300770-18350-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <1288807054.16859.2.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-10-28 at 14:19 -0700, Stephen Boyd wrote:
> We want to allow machines to override the __delay() implementation
> at runtime so they can use a timer based __delay() routine. It's
> easier to do this using C, so let's write udelay and friends in C.
> 
> We lose the #if 0 code, which according to Russell is used "to
> make the delay loop more stable and predictable on older CPUs"
> (see http://article.gmane.org/gmane.linux.kernel/888867 for more
> info). We shouldn't be too worried though, since we'll soon add
> functionality allowing a machine to set the __delay() loop
> themselves, thus allowing machines to resurrect the commented out
> code should they need it.
> 
> Nico expressed concern that fixed lpj cmdlines will break due to
> compiler optimizations. That doesn't seem to be the case since
> before and after this patch I get the same lpj value when running
> my CPU at 19.2 MHz. That should be sufficiently slow enough to
> cover any machine running Linux.

Nico, are you ready to sign off on this?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
