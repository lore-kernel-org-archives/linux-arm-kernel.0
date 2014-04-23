From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Apr 2014 10:37:01 +0100
Subject: [PATCH] ARM: Fix double definition of virt_to_pfn()
In-Reply-To: <1398238547-23065-1-git-send-email-peter.ujfalusi@ti.com>
References: <20140422195514.GA13106@arch.cereza>
 <1398238547-23065-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20140423093700.GF24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 10:35:47AM +0300, Peter Ujfalusi wrote:
> One definition of virt_to_pfn() was outside of the #if #elif #else section
> causing constant redefinition of the macro.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> the redefinition actually coming from different source. It is caused by the
> leftover definition of virt_to_pfn() which would redefine the virt_to_pfn()
> all the time.
> 
> The redefinition still exist in next-20140423.

Please see the thread "Re: [PATCH v7 2/2] ARM hibernation / suspend-to-disk"
this month.  The fixed up commit will be pushed out shortly.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
