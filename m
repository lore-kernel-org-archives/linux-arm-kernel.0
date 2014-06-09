From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Jun 2014 11:56:58 -0700
Subject: [PATCH v3] clk: exynos5420: Remove aclk66_peric from the clock
 tree description
In-Reply-To: <20140606234155.10062.58609@quantum>
References: <1401467562-5585-1-git-send-email-dianders@chromium.org>
 <1402000514-30752-1-git-send-email-dianders@chromium.org>
 <5390EE97.9020702@gmail.com> <20140606234155.10062.58609@quantum>
Message-ID: <CAD=FV=UZape0qnV0wfYUdtS-spkOAQxt1s1vrmG96H+WpyhW6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Fri, Jun 6, 2014 at 4:41 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Tomasz Figa (2014-06-05 15:26:31)
>> On 05.06.2014 22:35, Doug Anderson wrote:
>> > The "aclk66_peric" clock is a gate clock with a whole bunch of gates
>> > underneath it.  This big gate isn't very useful to include in our
>> > clock tree.  If any of the children need to be turned on then the big
>> > gate will need to be on anyway.  ...and there are plenty of other "big
>> > gates" that aren't described in our clock tree, some of which shut off
>> > collections of clocks that have no relationship in the hierarchy so
>> > are hard to model.
>> >
>> > "aclk66_peric" is causing earlyprintk problems since it gets disabled
>> > as part of the boot process, so let's just remove it.
>> >
>> > Strangely (and for no good reason) this clock is exported as part of
>> > the common clock bindings.  Remove it since there are no in-kernel
>> > device trees using it and no reason anyone out of tree should refer to
>> > it either.
>> >
>> > Signed-off-by: Doug Anderson <dianders@chromium.org>
>> > ---
>> > Changes in v3:
>> > - Now just remove aclk66_peric from the tree as suggested by Tomasz.
>> >
>> > Changes in v2:
>> > - Use GATE_A and clk_get().  Save the clock for putting later.
>> > - Return 0 from exynos5420_clk_late_init().
>> >
>> >  drivers/clk/samsung/clk-exynos5420.c   | 85 ++++++++++++++++++++++------------
>> >  include/dt-bindings/clock/exynos5420.h |  1 -
>> >  2 files changed, 55 insertions(+), 31 deletions(-)
>> >
>>
>> Mike, I can take this patch to my tree as a fix for 3.16-rc, or if still
>> possible and you don't mind, feel free to apply it directly with my ACK:
>>
>> Acked-by: Tomasz Figa <t.figa@samsung.com>
>
> I'll send a second PR next week that includes this.

This doesn't apply cleanly to Mike's tree.  Can you add it to your
tree and send it out for 3.16?  Mike said you should add his Ack and
I've confirmed that the patch applies cleanly to the most recent
linuxnext (next-20140606) as well as to the top of your
'samsung-clk-next' tree (2ce16c5 clk: samsung: exynos3250: Add clocks
using common clock framework).

Thanks!

-Doug
