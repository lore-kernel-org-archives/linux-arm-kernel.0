From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 17:41:14 +0100
Subject: [PATCH v3 0/7] arm64: Privileged Access Never using TTBR0_EL1
 switching
In-Reply-To: <20160915162044.GB19214@leverpostej>
References: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
 <20160915162044.GB19214@leverpostej>
Message-ID: <20160915164114.GC19214@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 05:20:45PM +0100, Mark Rutland wrote:
> Don't we need to fix up do_sysinstr() (which performs raw cache
> maintenance ops on __user addresses) with
> uaccess_{enable,disable}_not_uao()?

Actually, we don't even need to do anything in the case of PAN since
cache ops aren't affected by PAN/UAO; we just need to map/unmap in the
TTBR0-switching case to ensure we don't get stup fixing things up
forever.

/me commences name bikeshedding.

Thanks,
Mark.
