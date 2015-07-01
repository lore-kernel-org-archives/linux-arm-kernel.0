From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Jul 2015 12:12:51 +0100
Subject: [PATCH v5] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <1435699746-21395-1-git-send-email-lorenx4@gmail.com>
References: <1435699746-21395-1-git-send-email-lorenx4@gmail.com>
Message-ID: <20150701111251.GA21981@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 11:29:06PM +0200, Lorenzo Nava wrote:
> This patch allows the use of CMA for DMA coherent memory allocation.
> At the moment if the input parameter "is_coherent" is set to true
> the allocation is not made using the CMA, which I think is not the
> desired behaviour.
> 
> Signed-off-by: Lorenzo Nava <lorenx4@gmail.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

If Russell doesn't have any objections, you can send the patch to
his patch system. See here for more information:

http://www.arm.linux.org.uk/developer/patches/info.php

Or, if you are into git aliases (I haven't used this alias recently):

[alias]
	send-rmk-patch = !GIT_EDITOR=\"sed -i -e \\\"s/^---$/---\\nKernelVersion: $(git describe --abbrev=0 --match=\"v*\")\\n/\\\"\" git send-email --annotate --no-thread --suppress-cc=all --to="patches at arm.linux.org.uk"

Just make sure you send one at a time if you have a series. E.g. for the
top commit:

	git send-rmk-patch HEAD^

-- 
Catalin
