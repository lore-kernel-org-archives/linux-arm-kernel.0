From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Mar 2016 10:19:13 +0100
Subject: [PATCH] pwm: bcm7038: fix check of error code returned by
 devm_ioremap_resource()
In-Reply-To: <1457227306-3142-1-git-send-email-vz@mleia.com>
References: <1457227306-3142-1-git-send-email-vz@mleia.com>
Message-ID: <20160307091913.GF31189@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2016 at 03:21:46AM +0200, Vladimir Zapolskiy wrote:
> The change fixes potential oops while accessing iomem on invalid
> address, if devm_ioremap_resource() fails due to some reason.
> 
> The devm_ioremap_resource() function returns ERR_PTR() and never
> returns NULL, which makes useless a following check for NULL.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")
> ---
>  drivers/pwm/pwm-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160307/c15a84f9/attachment.sig>
