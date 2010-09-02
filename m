From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 2 Sep 2010 11:34:23 +0300
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100901232307.GC25860@n2100.arm.linux.org.uk>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
Message-ID: <20100902083423.GI25559@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 02, 2010 at 12:23:07AM +0100, Russell King - ARM Linux wrote:
> 
> The only thing this should be doing is turning off the MMU and jumping to
> the provided pointer.

I have one question related to this.

When the MMU is turned off, should we be running on 1:1 mappings?

For example on OMAP3430 (with latest mainline kernel + this patch)
kexec hangs just after "Bye!" message is displayed on console. It
works fine when cpu_v7_reset() is run via __pa(cpu_v7_reset).

Thanks,
MW
