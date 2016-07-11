From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 10:55:23 +0200
Subject: [PATCH v2 1/3] pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default
 value
In-Reply-To: <1467032997-5340-2-git-send-email-slemieux.tyco@gmail.com>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
 <1467032997-5340-2-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <20160711085523.GC5823@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 09:09:55AM -0400, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> The PWM_PIN_LEVEL bit is leave unset by the kernel PWM driver.
> 
> Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
> the PWM_PIN_LEVEL bit was always clear when the PWM was disable
> and a 0 logic level was apply to the output.
> 
> According to the LPC32x0 User Manual [1],
> the default value for bit 30 (PWM_PIN_LEVEL) is 0.
> 
> This change initialize the pin level to 0 (default value) and
> update the register value accordingly.
> 
> [1] http://www.nxp.com/documents/user_manual/UM10326.pdf
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> Changes from v1 to v2:
> * Only setup the "PWMx_PIN_LEVEL" once on probe.
> 
>  drivers/pwm/pwm-lpc32xx.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/1096e082/attachment.sig>
