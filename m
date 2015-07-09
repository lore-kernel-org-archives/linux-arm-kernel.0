From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Thu, 09 Jul 2015 15:36:54 -0400
Subject: [PATCH 3/3] regulator: 88pm800: Add dev_info to show probe
 success status
In-Reply-To: Your message of "Thu, 09 Jul 2015 18:11:32 +0530."
 <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <13146.1436470614@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Jul 2015 18:11:32 +0530, Vaibhav Hiremath said:
> This patch adds dev_info line at the end of probe function, to
> clearly put status of regulator probe on console. Useful during
> development, specially to check bootlog.

I can see that as a development thing...

> +	dev_info(&pdev->dev, "Regulator registered ...\n");

In which case this should be 'dev_debug()' or similar so it doesn't
clutter up and slow down a production boot.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/75eaec9e/attachment.sig>
