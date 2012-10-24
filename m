From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 24 Oct 2012 07:41:14 +0200
Subject: [PATCH v3] pwm: vt8500: Update vt8500 PWM driver support
In-Reply-To: <1351050418-23981-1-git-send-email-linux@prisktech.co.nz>
References: <20121023221419.GA8501@avionic-0098.mockup.avionic-design.de>
 <1351050418-23981-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121024054114.GA9787@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 04:46:58PM +1300, Tony Prisk wrote:
> This patch updates pwm-vt8500.c to support devicetree probing and
> make use of the common clock subsystem.
> 
> A binding document describing the PWM controller found on
> arch-vt8500 is also included.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> v2/v3:
> Fix errors/coding style as pointed out by Thierry Reding.
> 
>  .../devicetree/bindings/pwm/vt8500-pwm.txt         |   17 ++++
>  drivers/pwm/pwm-vt8500.c                           |   86 ++++++++++++++------
>  2 files changed, 80 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt

Looking real good now. One last comment though and I think I'm ready to
take this...

> +	err = clk_enable(vt8500->clk);
> +	if (err < 0)
> +		dev_err(chip->dev, "failed to enable clock\n");
> +		return -EBUSY;
> +	};

Why do you return EBUSY instead of err?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121024/b14ec1cd/attachment.sig>
