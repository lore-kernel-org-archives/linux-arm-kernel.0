From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 14:14:09 +0000
Subject: [PATCH 4/4] arm64: align PHYS_OFFSET to block size
In-Reply-To: <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150325141409.GD26903@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 04:36:56PM +0100, Ard Biesheuvel wrote:
> This aligns PHYS_OFFSET down to an alignment that allows system
> RAM to be mapped using the largest blocks available, i.e., 1 GB
> blocks on 4 KB pages or 512 MB blocks on 64 KB pages.

Does this assume that the platform RAM starts at such block aligned
addresses? If not, is the unaligned range ignored?

-- 
Catalin
