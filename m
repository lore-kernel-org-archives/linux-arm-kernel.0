From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 23 May 2013 19:19:30 +0800
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <201305231259.43750.arnd@arndb.de>
References: <519DCBEF.3090208@asianux.com> <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
 <201305231259.43750.arnd@arndb.de>
Message-ID: <519DFB42.7010509@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2013 06:59 PM, Arnd Bergmann wrote:
> You don't just want to avoid the code for printing the bug message and
> the invalid instruction, we also want the compiler to not emit the 
> function call or check the enum for unexpected values. The meaning of
> BUG() is really that person writing that statement was sure it cannot
> happen unless there is a bug in the kernel, which has likely already
> corrupted data. Printing a diagnostic at this point is nice if someone
> is there to look at it, but letting the kernel do further actions that
> may be undefined is not going to make things worse.

So I think neither unreachable() nor panic() are suitable for this
condition.

I guess 'CONFIG_BUG' is not belong to common features, now (and in the
future), so it is not suitable still exist in "asm-generic/bug.h", need
remove it firstly.

And then let the specific architectures to implement their own BUG(), if
they want some special features.

SO most of arches can skip this issue.


Thanks.
-- 
Chen Gang

Asianux Corporation
