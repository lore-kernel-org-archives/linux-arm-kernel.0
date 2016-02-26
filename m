From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Feb 2016 15:20:51 +0000
Subject: [PATCH v4] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <1456364697-25083-1-git-send-email-ddaney.cavm@gmail.com>
References: <1456364697-25083-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160226152051.GM4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 05:44:57PM -0800, David Daney wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
> On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
> instructions may cause the icache to become corrupted if it contains
> data for a non-current ASID.
> 
> This patch implements the workaround (which invalidates the local
> icache when switching the mm) by using code patching.
> 
> Signed-off-by: Andrew Pinski <apinski@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
