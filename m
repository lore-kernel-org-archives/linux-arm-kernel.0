From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jun 2015 20:40:58 +0100
Subject: [PATCH] ARM: fix DEBUG_UART_PHYS/VIRT issue when modifying
 DEBUG_LL output
In-Reply-To: <20150617144656.61eb29ae@free-electrons.com>
References: <1421145468-4144-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150617144656.61eb29ae@free-electrons.com>
Message-ID: <20150617194058.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 02:46:56PM +0200, Thomas Petazzoni wrote:
> What is the status of this patch? It would actually be quite useful
> when switching back and forth between different DEBUG_LL configurations.
> 
> Russell, what do you think of the proposed approach?

I'd rather we killed all the defaults, rather than keep trying to fix
these subtle issues.  That was always my goal of converting to this
model anyway.

However, I think it's important not to loose this information (how many
of us with lots of different platforms want to keep on digging through
PDFs to try and find this documentation?)  I'd like to see a per-SoC
file somewhere in Documentation/arm/ giving these details so at least
they're relatively easy to find.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
