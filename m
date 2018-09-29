From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Sat, 29 Sep 2018 04:52:30 +0200
Subject: [PATCH] arm: support big-endian for the virt architecture
In-Reply-To: <CAK8P3a3riqD9kzGZHLxhYug7zO34e2icOaWddzH2JezbZKVNPg@mail.gmail.com>
References: <20180926135110.13061-1-Jason@zx2c4.com>
 <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
 <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
 <CAK8P3a3riqD9kzGZHLxhYug7zO34e2icOaWddzH2JezbZKVNPg@mail.gmail.com>
Message-ID: <CAHmME9rGgnNTd84-ywcNZfRx0a3dnqUaCMoSkKHYSUPN1jZiew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Arnd,

On Fri, Sep 28, 2018 at 9:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> You can probably work around it by enabling ARCH_HIGHBANK,
> which is a minimal platform with no other requirements, so it
> should only add a few milliseconds to the build.

Nice hack, thanks for the suggestion. Committed here:
https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/WireGuard.git/commit/?id=56ff2eb9480e6c691a5b8d8ff1fa01090df61e1d

> Another option would be to do the testing on top of linux-next,
> which should have your fix starting on Monday. Testing on
> linux-next carries a higher risk of running into unrelated
> regressions, but also lets you find out about conflicts with
> other patches early on.

I do actually test on linux-next (and tons of other kernels too), but
I like to have things working for at least the latest mainline.

Jason
