From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 12 Jan 2015 13:54:11 +0100
Subject: [PATCH v3 1/5] usb: atmel_usba_udc: Rework at91sam9rl errata
 handling
In-Reply-To: <1421064958.22660.54.camel@x220>
References: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421060278-27329-2-git-send-email-boris.brezillon@free-electrons.com>
 <1421064958.22660.54.camel@x220>
Message-ID: <20150112135411.29c6315e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Mon, 12 Jan 2015 13:15:58 +0100
Paul Bolle <pebolle@tiscali.nl> wrote:

> On Mon, 2015-01-12 at 11:57 +0100, Boris Brezillon wrote:
> > at91sam9rl SoC has an erratum forcing us to toggle the BIAS on USB
> > suspend/resume events.
> > 
> > This specific handling is only activated when CONFIG_ARCH_AT91SAM9RL is
> > set and this option is only set when building a non-DT kernel, which is
> > problematic since non-DT support for at91sam9rl SoC has been removed.
> 
> This sentence is not entirely correct. Commit bcf8c7e7703b ("ARM: at91:
> remove at91sam9rl legacy board support") actually removed the Kconfig
> symbol ARCH_AT91SAM9RL entirely. So the check for CONFIG_ARCH_AT91SAM9RL
> has been pointless since (next-20141110 and) v3.19-rc1. See my report at
> https://lkml.org/lkml/2014/11/10/232 .

I'll rework my commit message.

> 
> (I stumbled on this patch because I contemplated sending a patch to
> simply remove the check for CONFIG_ARCH_AT91SAM9RL and the currently
> useless function toggle_bias.)

Sorry, I forgot to add you in Cc of this series :-(, I'll do it it for
the future iterations.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
