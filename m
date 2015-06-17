From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Jun 2015 22:10:04 +0200
Subject: [PATCH] ARM: fix DEBUG_UART_PHYS/VIRT issue when modifying
 DEBUG_LL output
In-Reply-To: <20150617194058.GZ7557@n2100.arm.linux.org.uk>
References: <1421145468-4144-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150617144656.61eb29ae@free-electrons.com>
 <20150617194058.GZ7557@n2100.arm.linux.org.uk>
Message-ID: <20150617221004.58699b2e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 17 Jun 2015 20:40:58 +0100, Russell King - ARM Linux wrote:

> > Russell, what do you think of the proposed approach?
> 
> I'd rather we killed all the defaults, rather than keep trying to fix
> these subtle issues.  That was always my goal of converting to this
> model anyway.
> 
> However, I think it's important not to loose this information (how many
> of us with lots of different platforms want to keep on digging through
> PDFs to try and find this documentation?)  I'd like to see a per-SoC
> file somewhere in Documentation/arm/ giving these details so at least
> they're relatively easy to find.

I personally find having the defaults for various popular platforms
readily available in menuconfig to be a lot easier than having to dig
some documentation to find the appropriate addresses.

I.e, the current way is perfect. It's just that there is no need to
show the physical/virtual addresses if an existing well-known platform
is selected, especially as it causes weird behavior due to how kconfig
works. Which Boris patch is solving.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
