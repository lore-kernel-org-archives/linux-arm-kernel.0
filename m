From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 24 Nov 2014 10:54:16 +0100
Subject: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
In-Reply-To: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <CAPDyKFqZyUT+sARZQ2ncusttDWn31uQf_H2eTtHOSCs2c8yO4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 November 2014 at 01:51, Vincent Yang
<vincent.yang.fujitsu@gmail.com> wrote:
> Hello,
>
>   Fujitsu have an sdhci IP which is implemented in a SoC we're
> adding to mainline, the most recent series for that was sent
> here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304522.html
>
>   These patches are against v3.18-rc5 mainline and tested on
> v3.18-rc5 integration tree.
>
>   We welcome any comment and advice about how to make any
> improvements or better align them with upstream.

Apparently, there's a dependency between this patchset and the upper
one you refereed to. That's a problem.

Preferably, try to remove the dependency and send all mmc patches to
the mmc list. If that's not possible, you need to send these two
patchsets as one instead.

>
> Thanks.
>
> Vincent Yang (4):
>   mmc: sdhci: add a voltage switch callback function
>   mmc: sdhci: add a quirk for tuning work around
>   mmc: sdhci: add a quirk for single block transactions
>   mmc: core: hold SD Clock before CMD11 during Signal

The last one I consider as a separate fix for mmc core. I will apply
it to my mmc tree.

Thanks and kind regards
Uffe
