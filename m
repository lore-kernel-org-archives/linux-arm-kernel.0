From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 12:24:26 +0000
Subject: [PATCH] ARM: move __fixup_smp out of init section
In-Reply-To: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
References: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140226122426.GX21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 12:16:33PM -0600, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> With large kernel builds such as allyesconfig exceeding maximum relative
> branch offsets, the init section will be too far away to branch to
> directly. This causes veneers to be added by the compiler, but veneers

Don't you mean the linker?  The compiler isn't involved here.  Can
you show the disassembly of the veneer please?

I'm confused why the linker would add a veneer for this, but not for
the stuff built by the compiler.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
