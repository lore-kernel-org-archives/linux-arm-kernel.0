From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 17:45:22 +0200
Subject: [PATCH v3 6/7] pwm: rockchip: Add rk3328 pwm support
In-Reply-To: <1502206967-24366-1-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206967-24366-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170818154522.GH18307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 11:42:47PM +0800, David Wu wrote:
> The rk3328 soc supports atomic update, we could lock the configuration
> of period and duty at first, after unlock is configured, the period and
> duty are effective at the same time.
> 
> If the polarity, period and duty need to be configured together,
> the way for atomic update is "configure lock and old polarity" ->
> "configure period and duty" -> "configure unlock and new polarity".
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pwm/pwm-rockchip.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)

Applied to for-4.14/drivers.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/78535116/attachment.sig>
