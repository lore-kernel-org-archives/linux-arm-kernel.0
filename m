From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Apr 2017 15:10:47 +0200
Subject: [PATCH v3] pwm: rockchip: State of pwm clock should synchronize
 with pwm enabled state
In-Reply-To: <1488366655-31387-1-git-send-email-david.wu@rock-chips.com>
References: <1488366655-31387-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170406131047.GA8438@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 07:10:55PM +0800, David Wu wrote:
> From: "david.wu" <david.wu@rock-chips.com>

You might want to set up git to use the correct author.

> If the pwm was not enabled at uboot loader, pwm could not work for clock
> always disabled at pwm driver. The pwm clock is enabled at beginning of
> pwm_apply(), but disabled at end of pwm_apply().
> 
> If the pwm was enabled at uboot loader, pwm clock is always enabled unless
> closed by ATF. The pwm-backlight might turn off the power at early suspend,
> should disable pwm clock for saving power consume.
> 
> It is important to provide opportunity to enable/disable clock at pwm driver,
> the pwm consumer should ensure correct order to call pwm enable/disable, and
> pwm driver ensure state of pwm clock synchronized with pwm enabled state.

Please always use all-caps for abbreviations suchs as "PWM". I've fixed
up the commit message and applied this to for-4.11/fixes.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/7673ddd4/attachment.sig>
