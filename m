From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Feb 2013 16:31:44 +0000
Subject: [PATCH 2/2] ARM: mm: perform explicit branch predictor
 maintenance when required
In-Reply-To: <1361805688-8886-2-git-send-email-will.deacon@arm.com>
References: <1361805688-8886-1-git-send-email-will.deacon@arm.com>
 <1361805688-8886-2-git-send-email-will.deacon@arm.com>
Message-ID: <20130225163143.GE612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 03:21:28PM +0000, Will Deacon wrote:
> The ARM ARM requires branch predictor maintenance if, for a given ASID,
> the instructions at a specific virtual address appear to change.
> 
> From the kernel's point of view, that means:
> 
> 	- Changing the kernel's view of memory (e.g. switching to the
> 	  identity map)
> 	- ASID rollover (since ASIDs will be re-allocated to new tasks)
> 
> This patch adds explicit branch predictor maintenance when either of the
> two conditions above are met.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
