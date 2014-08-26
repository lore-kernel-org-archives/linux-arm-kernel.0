From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 15:41:39 +0200
Subject: [PATCH v5 1/3] pwm: rockchip: Allow polarity invert on rk3288
In-Reply-To: <1409007567-23523-2-git-send-email-dianders@chromium.org>
References: <1409007567-23523-1-git-send-email-dianders@chromium.org>
 <1409007567-23523-2-git-send-email-dianders@chromium.org>
Message-ID: <20140826134138.GA2980@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 03:59:25PM -0700, Doug Anderson wrote:
> The rk3288 has the ability to invert the polarity of the PWM.  Let's
> enable that ability.  Note that this increases pwm_cells to 3 for
> rk3288.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
> Changes in v5: None
> Changes in v4:
> - Updated comment not to add caveats about pwm_cells 3.
> - rockchip_pwm_set_polarity() is now static.
> - Separate pwm_ops for v1 and v2; no set_polarity() in v1.
> - Added a blank line.
> 
> Changes in v3:
> - Don't store a private copy of polarity.
> - Use true instead of 1.
> - Cleanup init order with "has_invert".
> 
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       |  4 +-
>  drivers/pwm/pwm-rockchip.c                         | 57 ++++++++++++++++++----
>  2 files changed, 50 insertions(+), 11 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/3b9f1c55/attachment.sig>
