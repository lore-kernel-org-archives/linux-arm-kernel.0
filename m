From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 23 Aug 2016 17:34:43 +0200
Subject: [PATCH] crypto: rockchip - use devm_add_action_or_reset()
In-Reply-To: <1471964334-27060-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1471964334-27060-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <1832912.bMZSrNDq9I@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. August 2016, 20:28:54 schrieb Sudip Mukherjee:
> If devm_add_action() fails we are explicitly calling the cleanup to free
> the resources allocated.  Lets use the helper devm_add_action_or_reset()
> and return directly in case of error, as we know that the cleanup function
> has been already called by the helper if there was any error.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

nice little cleanup
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
