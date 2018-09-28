From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 21:19:12 +0200
Subject: [PATCH] arm: support big-endian for the virt architecture
In-Reply-To: <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
References: <20180926135110.13061-1-Jason@zx2c4.com>
 <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
 <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
Message-ID: <CAK8P3a3riqD9kzGZHLxhYug7zO34e2icOaWddzH2JezbZKVNPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 6:04 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Arnd,
>
> On Fri, Sep 28, 2018 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Applied for 4.20 with subject line changed s/arm/ARM/, thanks!
>
> Thanks.
>
> > I think most people just build a 'defconfig' kernel, which includes
> > multiple platforms that use ARCH_SUPPORTS_BIG_ENDIAN.
>
> Right, that's what it looked like. In my case, I'm doing CI on some
> homebrewed infra, where I'm building lots of kernels for lots of
> architectures and testing them in qemu with various tests _for each
> and every commit_. Not having a server farm as impressive as Intel's
> 0-day infra, getting compilation times down is rather important.

You can probably work around it by enabling ARCH_HIGHBANK,
which is a minimal platform with no other requirements, so it
should only add a few milliseconds to the build.

Another option would be to do the testing on top of linux-next,
which should have your fix starting on Monday. Testing on
linux-next carries a higher risk of running into unrelated
regressions, but also lets you find out about conflicts with
other patches early on.

       Arnd
