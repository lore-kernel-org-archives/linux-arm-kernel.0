From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 08:55:48 -0700
Subject: [PATCH v2] pinctrl: rockchip: fix rk3288 gpio0 configuration
In-Reply-To: <1406872680-14641-1-git-send-email-sonnyrao@chromium.org>
References: <1543632.JNPYWq24Lp@diego>
 <1406872680-14641-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <CAD=FV=WUHVGpULCN5WJGkC+Dqs7HX2w2-_PTG4tFwRpuHZF4PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sonny,

On Thu, Jul 31, 2014 at 10:58 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
> On rk3288, for gpio bank 0, the registers which configure pull-up,
> iomux, and drive strength don't implement the enable bits in the upper
> half of the register, unlike the other gpio configuration registers,
> and so the kernel must perform a read-modify-write of the register to
> update a particular gpio in that bank.
>
> The current code is actually clobbering the contents of the register,
> so this fixes it by using regmap_update_bits and masking out only the
> bits which require updating.  In the case of bank0 on rk3288 the upper
> enable bits will just get ignored, and the other configurations won't
> get clobbered.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
> v2: rebase onto latest pinctrl with drive strength and fix this bug on
>   iomux and drive strength as well.
>
>  drivers/pinctrl/pinctrl-rockchip.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
