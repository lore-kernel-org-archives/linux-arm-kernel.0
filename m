From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Jun 2016 18:12:48 +0100
Subject: [RFC PATCH 0/4] arm64: vdso: check whether the params is invalid
 address
In-Reply-To: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
References: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <20160606171248.GL669@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 11:05:58AM +0800, Yang Yingliang wrote:
> The params of gettimeofday(), clock_gettime() and clock_getres()
> is not checked. This will cause segment faults when the address is
> invalid. 
> E.g. gettimeofday(-1, -1);
>      clock_gettime(0, -1);
>      clock_getres(0, -1);
> This patchset add a macro and use it to check the validation of these
> pointer params.

Is this really necessary? It doesn't look to me like other architectures
bother with this, and you're just adding code to the fastpath to handle
cases that shouldn't happen to start with.

Also, I think I remember seeing SEGVs from libc wrappers for other syscalls
in the past, so this just isn't compelling to me.

Will
