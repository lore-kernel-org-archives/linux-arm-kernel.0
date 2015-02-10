From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Feb 2015 01:34:55 -0800
Subject: [PATCH] mmc: dw_mmc: fix bug that cause mmc_test failture
In-Reply-To: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAOesGMiWBjhfzWVXah2XO7=JQhriwdVgf0jmm1UjNQjB9PeGMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Addy,

On Mon, Jan 26, 2015 at 4:04 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
> The STOP command can terminate a data transfer between a memory card and
> mmc controller.
>
> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
> Data timeout and Data end-bit error will terminate further data transfer
> by mmc controller. So we should not send abort command to terminate a
> data transfer again if we got DRTO and EBE interrupt.
>
> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

The drawback of having so many people on your to: list on a patch is
that it's unclear who you want to review and merge it. Sometimes less
is more.

In this case, it seems appropriate to have Ulf do so. Ulf, ping? This
seems like a reasonable patch for 3.20 given that it fixes undesired
behavior.


-Olof
