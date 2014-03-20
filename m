From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Mar 2014 17:42:17 +0000
Subject: [PATCH v2] arm64: Fix __range_ok macro
In-Reply-To: <1395246577-22120-1-git-send-email-cov@codeaurora.org>
References: <1394059289-3972-1-git-send-email-cov@codeaurora.org>
 <1395246577-22120-1-git-send-email-cov@codeaurora.org>
Message-ID: <20140320174217.GB28238@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 04:29:37PM +0000, Christopher Covington wrote:
> Without this, the following scenario is incorrectly determined
> to be invalid.
> 
> addr 0x7f_ffffe000 size 8192 addr_limit 0x80_00000000
> 
> This behavior was observed while trying to vmsplice the stack
> as part of a CRIU dump of a process on a system started with the
> norandmaps kernel parameter.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>

Thanks, applied.

-- 
Catalin
