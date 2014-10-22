From: dianders@chromium.org (Doug Anderson)
Date: Wed, 22 Oct 2014 16:53:56 -0700
Subject: [PATCHv4 2/3] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <1414004860-17645-3-git-send-email-dinguyen@opensource.altera.com>
References: <1414004860-17645-1-git-send-email-dinguyen@opensource.altera.com>
 <1414004860-17645-3-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <CAD=FV=VaYzyqYf2Rm7=3Lp6zsYRjgurw+w3Y=D0zP2F6K_zmKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

On Wed, Oct 22, 2014 at 12:07 PM,  <dinguyen@opensource.altera.com> wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> Without this patch, the booting the SOCFPGA platform would hang at the
> SDMMC driver loading. The issue, debugged by Doug Anderson, turned out
> to be that the GPIO bank used by the SD card-detect was not set to
> status="okay".
>
> Also update the cd-gpios to point to portb of the &gpio1 GPIO IP.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v4: Use &gpio1 to set status="okay" and update cd-gpio=&portb
> v3: Correctly degugged the issue to be a gpio node not having status="okay"
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
