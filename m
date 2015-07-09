From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jul 2015 20:05:47 +0100
Subject: [PATCH 3/3] regulator: 88pm800: Add dev_info to show probe
 success status
In-Reply-To: <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150709190547.GQ11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 06:11:32PM +0530, Vaibhav Hiremath wrote:
> This patch adds dev_info line at the end of probe function, to
> clearly put status of regulator probe on console. Useful during
> development, specially to check bootlog.

> +	dev_info(&pdev->dev, "Regulator registered ...\n");
>  	return 0;

No, this is pure noise - all you're doing is slowing down boot for users
with no content.  Think about what would happen if every driver did
this.  The core already displays the constraints when things are
registered.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/4bdb1d8f/attachment.sig>
