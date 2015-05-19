From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 19 May 2015 10:51:12 +0800
Subject: [linux-sunxi] [RFC 0/7] ARM: sun9i: SMP support with
 Multi-Cluster Power Management
In-Reply-To: <1431770926.5748.41.camel@hellion.org.uk>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431770926.5748.41.camel@hellion.org.uk>
Message-ID: <CAGb2v66mhAOmAzZ1xPihjKUDtA_geHVFZzwrvnJh1ccWqq0Wpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 16, 2015 at 6:08 PM, Ian Campbell <ijc@hellion.org.uk> wrote:
> On Thu, 2015-05-14 at 14:10 +0800, Chen-Yu Tsai wrote:
>> This is my attempt to support SMP and CPU hot plugging on the Allwinner
>> A80 SoC. The A80 is a big.Little processor with 2 clusters of 4x Cortex-A7
>> and 4x Cortex-A15 cores.
>
> I thought there was a preference these days to support this sort of
> thing via support PSCI in the firmware, which allows for other things
> such as non-secure-world etc.

Ideally, yes. However, U-boot only has minimal A80 support for now.
Also, multi-cluster support is not as simple as what we had for the
A20. The kernel already has common multi-cluster code. With it we
can do full SMP/hotplug support. Kernel code is also easier to write
and debug than PSCI, which ATM is all per-platform assembly.

Also, my A31 and A23 PSCI implementations still need some work.

ChenYu
