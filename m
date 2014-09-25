From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 25 Sep 2014 19:15:25 +0200
Subject: [PATCH v7 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <CAGm_ybh-R1GsHF-BRhRYQKkCpQFQSE6Mem=A3kz=H3Bemor9xA@mail.gmail.com>
References: <1408625982-3267-1-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybh-R1GsHF-BRhRYQKkCpQFQSE6Mem=A3kz=H3Bemor9xA@mail.gmail.com>
Message-ID: <CABxcv=kHwCCYhit20qO1q=Nn3KVj8U=8cpCu=DQRuy+R86N0kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Pankaj Dubey to cc list]

Hello Vikas,

On Sun, Sep 14, 2014 at 4:57 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Hi All,
>
>
> On Thu, Aug 21, 2014 at 6:29 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>> Rebased on
>> 1] Kukjin Kim's tree, master branch
>> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/
>> 2] Pankaj Dubey's v7 PMU patchset
>> https://lkml.org/lkml/2014/7/9/2
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/270655.html

The mentioned patches from the PMU series depend on the patch to
decouple the syscon interface from syscon drivers. The latest version
of that patch is Pankaj's "[PATCH v5] mfd: syscon: Decouple syscon
interface from platform devices" [0].

There is still an ongoing discussion about the implementation details
since errors were reported (debugfs regmap dir failing to be created
due a NULL device name) so this won't be a definite version.

But I tested that patch on an Exynos5420 Peach Pit and it works so
maybe Pankaj can re-spin his PMU series on top of his latest syscon
patch so at least the dependencies for your series are sorted and
people can try it?

Best regards,
Javier

[0]: https://patchwork.kernel.org/patch/4945481/
