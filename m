From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Nov 2016 10:52:54 +0000
Subject: [bug report v4.8] fs/locks.c: kernel oops during posix lock
 stress test
In-Reply-To: <CACVXFVPsHjh3CWjdUrKB_r6=hkXK=qS3wpykbacdKe1rzz1H8Q@mail.gmail.com>
References: <CACVXFVPsHjh3CWjdUrKB_r6=hkXK=qS3wpykbacdKe1rzz1H8Q@mail.gmail.com>
Message-ID: <20161128105254.GB1485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming,

On Mon, Nov 28, 2016 at 11:10:14AM +0800, Ming Lei wrote:
> When I run stress-ng via the following steps on one ARM64 dual
> socket system(Cavium Thunder), the kernel oops[1] can often be
> triggered after running the stress test for several hours(sometimes
> it may take longer):
> 
> - git clone git://kernel.ubuntu.com/cking/stress-ng.git
> - apply the attachment patch which just makes the posix file
> lock stress test more aggressive
> - run the test via '~/git/stress-ng$./stress-ng --lockf 128 --aggressive'
> 
> 
> From the oops log, looks one garbage file_lock node is got
> from the linked list of 'ctx->flc_posix' when the issue happens.
> 
> BTW, the issue isn't observed on single socket Cavium Thunder yet,
> and the same issue can be seen on Ubuntu Xenial(v4.4 based kernel)
> too.

I've seen issues with the LSE atomics on the Thunder platform -- can you
try disabling those (CONFIG_ARM64_LSE_ATOMICS) and see if the problem
persists, please?

Will
