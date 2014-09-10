From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 17:47:56 +0100
Subject: [PATCH v9 4/6] ARM: add vdso user-space code
In-Reply-To: <1408744351-7814-5-git-send-email-nathan_lynch@mentor.com>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
 <1408744351-7814-5-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140910164755.GC1710@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

On Fri, Aug 22, 2014 at 10:52:29PM +0100, Nathan Lynch wrote:
> Place vdso-related user-space code in arch/arm/kernel/vdso/.
> 
> It is almost completely written in C with some assembly helpers to
> load the data page address, sample the counter, and fall back to
> system calls when necessary.

I'm still a bit puzzled as to how we can implement a compat version of this
for a 32-bit userspace running under a 64-bit kernel. Maybe the answer is
that we don't care enough (programs will still work fine without it), but if
we did want to then we're going to need to build the kernel with two
toolchains and it gets really horrible.

Do you have any ideas?

Will
