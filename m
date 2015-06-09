From: dianders@chromium.org (Doug Anderson)
Date: Tue, 9 Jun 2015 11:13:19 -0700
Subject: [PATCH v6 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <1433843400-24831-3-git-send-email-wxt@rock-chips.com>
References: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
 <1433843400-24831-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=W63LxYJtm=YyNmQynnL8SEJc6DkOtNQahnfVw=m0eBPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Jun 9, 2015 at 2:49 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> The patch can ensure that v7_exit_coherency_flush() in rockchip_cpu_die()
> executed in time.
> The mdelay(1) has enough time to fix the problem of CPU offlining.
> That's a workaround way in rockchip hotplug code,
> At least, we haven't a better way to solve it. Who know,
> that maybe fixed by chip (hardware) in the future.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> ---
>
> Changes in v6:
> - Fix the delay 1ms describing.
> Series-changes: 5
> - Fix the patch decription.
> - Add the changelog.
> Series-changes: 2
> - As Kever points out, Fix the subject typo WFI/WFE.
>
>  arch/arm/mach-rockchip/platsmp.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
