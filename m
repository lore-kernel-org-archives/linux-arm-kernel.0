From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 26 May 2018 09:22:51 -0700
Subject: [GIT PULL] Allwinner core changes for 4.18
In-Reply-To: <20180525210218.orjdivwnkm6j4d4q@localhost>
References: <20180521114156.6nppm5vomksxpeqv@flea>
 <20180525210218.orjdivwnkm6j4d4q@localhost>
Message-ID: <CAGb2v64Febv7ZLZbcTqR6+say38xu25gj0n+dbY-8KAyygDpJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 2:02 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, May 21, 2018 at 01:41:56PM +0200, Maxime Ripard wrote:
>> Hi,
>>
>> Here is our mach-sunxi changes for the next merge window, thanks!
>> Maxime
>>
>> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>>
>>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-core-for-4.18
>>
>> for you to fetch changes up to 6961275e72a8c15cc4ebf108a81eee758480a6a2:
>>
>>   ARM: sun8i: smp: Add support for A83T (2018-05-08 15:00:20 +0200)
>>
>> ----------------------------------------------------------------
>> Allwinner core changes for 4.18
>>
>> The A83t, unlike the other Allwinner SoCs, cannot use PSCI because of a
>> silicon bug. As such, we needed to have some smp_ops in order to bringup
>> the various cores (and clusters) found on this SoC.
>
> Hrm. that's unfortunate. Is there any public documentation of what the bug is?

The security extensions in the A80 and A83T is not entirely enabled.
The security bit is not forwarded on to the bus, so all accesses from
non-secure become secure. This is not documented, but was the result
of some tests I did.

See https://lists.denx.de/pipermail/u-boot/2017-June/294672.html
for a summary (in the quotes) of what we think is the issue.

Marc's suggestion is that if virtualization doesn't work on it, then
there's no point in running it non-secure. [1]

ChenYu

[1] https://lists.denx.de/pipermail/u-boot/2017-June/294697.html
