From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Sep 2014 16:02:12 +0100
Subject: [PATCH v2] arm64: add guard macros of unistd.h to prevent double
 inclusion
In-Reply-To: <5411698E.3000402@huawei.com>
References: <1410235185-16652-1-git-send-email-yangyingliang@huawei.com>
 <20140909123938.GL1754@arm.com> <54115583.8080306@huawei.com>
 <5411698E.3000402@huawei.com>
Message-ID: <20140911150212.GP6158@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 10:21:18AM +0100, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> Add guard macros for uapi/asm/unistd.h, asm/unistd.h and
> asm/unistd32.h.

Hmm, so I applied this and now my machine panics when we hit userspace. I
think the issue is that we no longer generate our syscall table in
arch/arm64/kernel/sys.c, because unistd.h is already included via
linux/syscalls.h but without the __SYSCALL definition.

So, a couple of questions:

  (1) Is the lack of header guards actually causing you a problem?
  (2) How did you test this?

I've dropped the patch.

Will
