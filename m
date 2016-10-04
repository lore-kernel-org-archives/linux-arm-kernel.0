From: dianders@chromium.org (Doug Anderson)
Date: Tue, 4 Oct 2016 15:14:29 -0700
Subject: [PATCH v2 1/2] clocksource: arm_arch_timer: Don't assume clock
 runs in suspend
In-Reply-To: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
References: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=VO2f78AMRfWbhn8MZ8y1wKFPUdOf64BUpKuS+GEvnWGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 4, 2016 at 11:12 AM, Brian Norris <briannorris@chromium.org> wrote:
> The ARM ARM specifies that the system counter "must be implemented in an
> always-on power domain," and so we try to use the counter as a source of
> timekeeping across suspend/resume. Unfortunately, some SoCs (e.g.,
> Rockchip's RK3399) do not keep the counter ticking properly when
> switched from their high-power clock to the lower-power clock used in
> system suspend. Support this quirk by adding a new device tree property.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
>  * add new device tree property, instead of re-using the "always-on"
>    property (which has different meaning)
>
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 5 +++++
>  drivers/clocksource/arm_arch_timer.c                 | 9 ++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
