From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 16 Oct 2015 20:56:55 +0200
Subject: [PATCH v2 1/2] clk: samsung: exynos5250: Add DISP1 clocks
In-Reply-To: <20151016172651.GB23912@codeaurora.org>
References: <1444905084-22540-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444905084-22540-2-git-send-email-tomeu.vizoso@collabora.com>
 <56203AD3.2050905@samsung.com> <20151016124935.20687.4394@quantum>
 <20151016172651.GB23912@codeaurora.org>
Message-ID: <CAAObsKAjZX8XxTAFVKq4BCSZSrKG5xQPTue+z+xnJDD8QwK88Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2015 at 19:26, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/16, Michael Turquette wrote:
>> Quoting Krzysztof Kozlowski (2015-10-15 16:46:27)
>> > On 15.10.2015 19:31, Tomeu Vizoso wrote:
>> > > When the DISP1 power domain is powered off, there's two clocks that need
>> > > to be temporarily reparented to OSC, and back to their original parents
>> > > when the domain is powered on again.
>> > >
>> > > We expose these two clocks in the DT bindings so that the DT node of the
>> > > power domain can reference them.
>> > >
>> > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>> > > ---
>> > >
>> > > Changes in v2:
>> > > - Reuse mout_aclk200_p
>> > > - Rename div_aclk300 as div_aclk300_disp
>> > >
>> > >  drivers/clk/samsung/clk-exynos5250.c   | 14 +++++++++++++-
>> > >  include/dt-bindings/clock/exynos5250.h |  4 +++-
>> > >  2 files changed, 16 insertions(+), 2 deletions(-)
>> > >
>> >
>> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> Applied to clk-next.
>>
>
> I think Tomeu wanted to take this through arm-soc? Otherwise
> we'll need to provide a stable branch for the dt header.

Hi, Stephen is right, the second patch depends on this one.

Thanks,

Tomeu

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
