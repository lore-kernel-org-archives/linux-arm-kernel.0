From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Oct 2018 14:15:52 +0200
Subject: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull
 mode
In-Reply-To: <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20181012121552.GE31561@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:01:25PM +0300, Claudiu Beznea wrote:
> Add documentation for PWM push-pull mode.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
>  Documentation/pwm.txt                         | 16 ++++++++++++++++
>  include/dt-bindings/pwm/pwm.h                 |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> index 7c8aaac43f92..6a60c0fca112 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of flags (defined in
>  - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM channels
>  with two outputs); if not specified, the default for PWM channel will be
>  used
> +- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels with
> +two outputs); if not specified the default for PWM channel will be used

What if somebody has this in the DT:

	PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL

which one takes precedence, or do we reject it?

Wouldn't it be preferable to either move the modes into an extra field
within the flags field, or perhaps even add another field?

I guess since Rob's already acked this, that concern may be unfounded.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181012/20a2201e/attachment.sig>
