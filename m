From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 00:03:34 -0700
Subject: [PATCH 3/9] ARM: zImage: make sure not to relocate on top of
	the relocation code
In-Reply-To: <1304031024-5121-4-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-4-git-send-email-nico@fluxnic.net>
Message-ID: <20110429070334.GP3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110428 15:47]:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> If the zImage load address is slightly below the relocation address,
> there is a risk for the copied data to overwrite the copy loop or
> cache flush code that the relocation process requires.  Always
> bump the relocation address by the size of that code to avoid this
> issue.
> 
> Noticed by Tony Lindgren <tony@atomide.com>.
> 
> While at it, let's start the copy from the restart symbol which makes
> the above code size computation possible by the assembler directly,
> given that we don't need to preserve the code before that point anyway.
> And therefore we don't need to carry the _start pointer in r5 anymore.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Cool, this works for my test case:

Tested-by: Tony Lindgren <tony@atomide.com>
