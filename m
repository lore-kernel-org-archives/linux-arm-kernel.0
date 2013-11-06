From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Nov 2013 15:29:09 +0000
Subject: [PATCH] arm,arm64: Conditionalize bio_vec usage
In-Reply-To: <1383743117-4138-1-git-send-email-treding@nvidia.com>
References: <1383743117-4138-1-git-send-email-treding@nvidia.com>
Message-ID: <20131106152909.GE979@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 01:05:17PM +0000, Thierry Reding wrote:
> Commit 3d1975b57097 (arm,arm64: do not always merge bio_vec if we are
> running on Xen) unconditionally added code using the bio_vec typedefs
> which causes build errors on configurations where CONFIG_BLOCK is
> disabled.

I guess this commit is only in -next. Would it have the same hash when
hitting mainline? Otherwise I'm fine with the patch, maybe Stephano can
pick it together with the patch that breaks it.

-- 
Catalin
