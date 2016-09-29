From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 29 Sep 2016 15:44:52 -0700
Subject: [kernel-hardening] Re: [PATCH v3 0/7] arm64: Privileged Access
 Never using TTBR0_EL1 switching
In-Reply-To: <20160915162044.GB19214@leverpostej>
References: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
 <20160915162044.GB19214@leverpostej>
Message-ID: <20160929224452.GA71670@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 05:20:45PM +0100, Mark Rutland wrote:
> Likewise, how do we handle __flush_cache_user_range and
> flush_icache_range? Some callers (e.g. __do_compat_cache_op) pass in
> __user addresses.

Also EXEC_USERSPACE in lkdtm passes a user space address to flush_icache_range
and causes the process to hang when I tested these patches on HiKey.

Adding uaccess_{enable,disable}_not_uao to __flush_cache_user_range appears to
fix the problem.

Sami
