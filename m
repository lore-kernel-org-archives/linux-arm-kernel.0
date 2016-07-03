From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 03 Jul 2016 23:34:07 +0200
Subject: [PATCH] phy: rockhip-usb: use devm_add_action_or_reset()
In-Reply-To: <1467579666-9179-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1467579666-9179-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <2045236.FJVOO9eQKE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 3. Juli 2016, 22:01:06 schrieb Sudip Mukherjee:
> If devm_add_action() fails we are explicitly calling the cleanup to free
> the resources allocated.  Lets use the helper devm_add_action_or_reset()
> and return directly in case of error, as we know that the cleanup function
> has been already called by the helper if there was any error.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

a nice new helper this devm_add_action_or_reset.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
