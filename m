From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Jun 2016 09:09:41 -0500
Subject: [PATCH 14/14] regulator: pwm: Document pwm-dutycycle-unit and
 pwm-dutycycle-range
In-Reply-To: <1464942192-25967-15-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-15-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160606140941.GA3601@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:23:12AM +0200, Boris Brezillon wrote:
> Document the pwm-dutycycle-unit and pwm-dutycycle-range properties.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/regulator/pwm-regulator.txt          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> index ed936f0..5303235 100644
> --- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> @@ -34,6 +34,18 @@ Only required for Voltage Table Mode:
>  			    First cell is voltage in microvolts (uV)
>  			    Second cell is duty-cycle in percent (%)
>  
> +Optional properties for Continuous mode:
> +- pwm-dutycycle-unit:	Integer value encoding the dutycycle unit. If not

dutycycle should be 2 words.

> +			defined, <100> is assumed, meaning that
> +			pwm-dutycycle-range contains values expressed in
> +			percent.

Perhaps an example not in percent. This is essentially the maximum 
value?

> +
> +- pwm-dutycycle-range:	Should contain 2 entries. The first entry is encoding
> +			the dutycycle for regulator-min-microvolt and the
> +			second one the dutycycle for regulator-max-microvolt.
> +			Dutycyle values are expressed in pwm-dutycycle-unit.

typo                    ^^^^^^^^

> +			If not defined, <0 100> is assumed.
> +
>  NB: To be clear, if voltage-table is provided, then the device will be used
>  in Voltage Table Mode.  If no voltage-table is provided, then the device will
>  be used in Continuous Voltage Mode.
> -- 
> 2.7.4
> 
