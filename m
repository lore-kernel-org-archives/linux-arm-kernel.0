From: dianders@chromium.org (Doug Anderson)
Date: Thu, 18 Dec 2014 16:36:14 -0800
Subject: [PATCH 1/3] mmc: dw_mmc: dt-binding: Add tuning related things
In-Reply-To: <1418943663-10012-2-git-send-email-amstan@chromium.org>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
 <1418943663-10012-2-git-send-email-amstan@chromium.org>
Message-ID: <CAD=FV=U_Qqjp6U7Nbu4RwjPf52sv6WHq6-oU3ktuMB67=F8Q0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> Add ciu_drv, ciu_sample clocks and default-sample-phase. This will later be used
> by tuning code.
>
> We do not touch ciu_drive (and by extension define default-drive-phase). Drive
> phase is mostly used to define minimum hold times, while one could write some
> code to determine what phase meets the minimum hold time (ex 10 degrees) this
> will not work with the current clock phase framework (which floors angles, so
> we'll get 0 deg, and there's no way to know what resolution the floors happen
> at). We assume that the default drive angles set by the hardware are good enough.
>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
