From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jun 2016 10:33:20 +0100
Subject: [RFC PATCH 0/4] arm64: vdso: check whether the params is invalid
 address
In-Reply-To: <5757E2E2.3010609@huawei.com>
References: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
 <20160606171248.GL669@arm.com> <5757E2E2.3010609@huawei.com>
Message-ID: <20160608093319.GB27029@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 05:18:26PM +0800, Yang Yingliang wrote:
> 
> 
> On 2016/6/7 1:12, Will Deacon wrote:
> >On Wed, Jun 01, 2016 at 11:05:58AM +0800, Yang Yingliang wrote:
> >>The params of gettimeofday(), clock_gettime() and clock_getres()
> >>is not checked. This will cause segment faults when the address is
> >>invalid.
> >>E.g. gettimeofday(-1, -1);
> >>      clock_gettime(0, -1);
> >>      clock_getres(0, -1);
> >>This patchset add a macro and use it to check the validation of these
> >>pointer params.
> >
> >Is this really necessary? It doesn't look to me like other architectures
> >bother with this, and you're just adding code to the fastpath to handle
> >cases that shouldn't happen to start with.
> I agree.
> 
> I find clock_gettime() don't check if tp is NULL. I think it need a
> checking like clock_getres().
> 
> What's your suggestion ?

So what? If you pass NULL then you get a SEGV. Just like if you pass a
NULL pointer to various glibc wrappers.

Don't pass NULL. Problem solved.

Will
