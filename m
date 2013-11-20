From: tj@kernel.org (Tejun Heo)
Date: Wed, 20 Nov 2013 10:06:58 -0500
Subject: [PATCH v2 3/4] ata: add APM X-Gene SoC 6.0Gbps SATA PHY driver
In-Reply-To: <1384905197-3566-4-git-send-email-lho@apm.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <1384905197-3566-2-git-send-email-lho@apm.com>
 <1384905197-3566-3-git-send-email-lho@apm.com>
 <1384905197-3566-4-git-send-email-lho@apm.com>
Message-ID: <20131120150658.GB28946@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey, guys.

On Tue, Nov 19, 2013 at 04:53:16PM -0700, Loc Ho wrote:
> This patch adds support for APM X-Gene SoC 6.0Gbps SATA PHY. This is the
> physical layer interface for the corresponding SATA host controller. This
> driver uses the new PHY generic framework posted by Kishon Vijay Abrahm.

Hmm... this is related to ahci but isn't even a libata driver and is
the first such driver proposed.  Are we sure drivers/ata is the best
home for this?  Shouldn't we create a separate directory somewhere?
It's confusing, at least to me, to have non-libata driver under
drivers/ata.

Thanks.

-- 
tejun
