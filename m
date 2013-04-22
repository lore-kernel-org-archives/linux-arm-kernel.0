From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:28:45 +0100
Subject: [RFC v2] video: ARM CLCD: Add DT & CDF support
In-Reply-To: <1366306402-21651-1-git-send-email-pawel.moll@arm.com>
References: <20130418102444.GL14496@n2100.arm.linux.org.uk>
 <1366306402-21651-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130422142845.GO14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 06:33:21PM +0100, Pawel Moll wrote:
> This patch adds basic DT bindings for the PL11x CLCD cells
> and make their fbdev driver use them, together with the
> Common Display Framework.
> 
> The DT provides information about the hardware configuration
> and limitations (eg. the largest supported resolution)
> but the video modes come exclusively from the Common
> Display Framework drivers, referenced to by the standard CDF
> binding.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Much better.

I will point out though that there be all sorts of worms here when you
come to the previous ARM evaluation boards (which is why the capabilities
stuff got written in the first place) where there's a horrid mixture of
BGR/RGB ordering at various levels of the system - some of which must be
set correctly because the CLCD output isn't strictly used as R bits
G bits and B bits (to support different formats from the CLCD's native
formats.)
