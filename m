From: yinghai@kernel.org (Yinghai Lu)
Date: Thu, 8 Nov 2012 14:39:02 -0800
Subject: [RFC] arm: memtest
In-Reply-To: <509C1A92.9080407@ahsoftware.de>
References: <509C1A92.9080407@ahsoftware.de>
Message-ID: <CAE9FiQWeie62NYt2vyq2q+Um8NeA5xWQGy-nULmFidt4XxW=BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 12:48 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Hello,
>
> I've recently discovered the lack of the command line parameter memtest for
> ARM. So I've made a patch.
>
> But I have some questions:
>
> 1. arch/x86/mm/memtest.c looks platform independ.
> The only thing why I don't use it for arm, is because it uses 64bit
> pointers. Maybe it could be moved to mm/memtest.c. If so, the memtest32.c
> I'm using (basically a copy of memtest.c) could be moved there too.
>
> 2. Because the below memtest32.c is basically a copy of
> arch/x86/mm/memtest.c, I'm not sure if the mapping from physical to virtual
> locations there does fit (always) for ARM too. I know almost as much about
> the in-kernel memory organization on x86 as on ARM, which is not really that
> much (some theory about TLBs, some source code explorations, ..., but I'm
> working on it). ;)

We are using arch/x86/mm/memtest.c for x86 32bit and 64bit.

So it should be ok to use it with arm 32bit and 64bit directly.

Yinghai
