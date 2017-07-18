From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jul 2017 13:39:48 +0200
Subject: [PATCH 6/7] staging: fsl-mc: rewrite mc command send/receive to
 work on 32-bits
In-Reply-To: <596DEC19.6060301@nxp.com>
References: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
 <20170717132646.3020-7-laurentiu.tudor@nxp.com>
 <CAK8P3a3KDh=MgfjG+sKNqcrQwq1yf-DgQN0=HigPaPYYJq0Uug@mail.gmail.com>
 <596CC912.3020709@nxp.com>
 <CAK8P3a3e+Gv2bdHKkRdNVp1e2-Z6j351cudLU4fuH2aZ8CSwmQ@mail.gmail.com>
 <596DEC19.6060301@nxp.com>
Message-ID: <CAK8P3a1HDSXXsSfSfOrHYSGLhNKOv__JAFVH-RVZAbojq+=AOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 1:08 PM, Laurentiu Tudor
<laurentiu.tudor@nxp.com> wrote:
> On 07/17/2017 06:00 PM, Arnd Bergmann wrote:

>> Strictly speaking the __raw_writel() won't guarantee that the
>> data is written as a single word, the compiler might decide to
>> split it up into byte-sized writes if it believes the destination pointer
>> is unaligned and the CPU has no efficient writes.
>>
>> I think this cannot happen on arm or powerpc, as we go through
>> inline assembly for the store, but it's not completely portable.
>
> Should i worry about portability? Slim changes that this driver
> will ever run on anything else other than ARM & ARM64.
> My current goal was just to make it compile on other arches.

I always recommend writing any driver in the most portable way
out of principle, since you never know who looks at it for reference
when writing another driver.

I wouldn't expect the driver itself to be used on other architectures,
but of course you never know what CPU becomes fashionable
10 years from now.

        Arnd
