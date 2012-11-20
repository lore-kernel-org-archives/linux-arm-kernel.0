From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Nov 2012 13:16:03 +0100
Subject: [PATCH v3 0/2] pwm fixes for 3.8
In-Reply-To: <1353347086-4572-1-git-send-email-linux@prisktech.co.nz>
References: <1353347086-4572-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121120121603.GA16752@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 06:44:44AM +1300, Tony Prisk wrote:
> Hi Theirry,
> 
> I felt the error message for clk_enable in vt8500_pwm_config() needed
> to somehow indicate that the clk_enable failed in this function otherwise
> if there is a problem, you can't tell which of the clk_enable's
> generated the fail message.
> If there is a clock error - as you pointed out - it will probably fail
> elsewhere as well so I've changed it to match the other error messages.
> 
> These should be applied on top of the original patch.
> 
> v2: Add error checking for clk_enable()
> v3: Remove superfluous ;'s. Error message style correction.
> 
> Tony Prisk (2):
>   Fix build error in pwm-vt8500.c
>   pwm: vt8500: Ensure pwm clock is enabled during pwm_config
> 
>  drivers/pwm/pwm-vt8500.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Applied with minor stylistic fixups to the commit message, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/b20f607e/attachment.sig>
