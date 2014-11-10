From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Nov 2014 15:58:52 +0100
Subject: [PATCH v6] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
In-Reply-To: <1413266961-3859-1-git-send-email-addy.ke@rock-chips.com>
References: <1413168244-3553-1-git-send-email-addy.ke@rock-chips.com>
 <1413266961-3859-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20141110145852.GD10422@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 02:09:21PM +0800, Addy Ke wrote:
> As show in I2C specification:
> - Standard-mode: the minimum HIGH period of the scl clock is 4.0us
>                  the minimum LOW period of the scl clock is 4.7us
> - Fast-mode: the minimum HIGH period of the scl clock is 0.6us
>              the minimum LOW period of the scl clock is 1.3us
> 
> I have measured i2c SCL waveforms in fast-mode by oscilloscope
> on rk3288-pinky board. the LOW period of the scl clock is 1.3us.
> It is so critical that we must adjust LOW division to increase
> the LOW period of the scl clock.
> 
> Thanks Doug for the suggestion about division formulas.
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/d2cf78fb/attachment.sig>
