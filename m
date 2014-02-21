From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Feb 2014 09:16:03 +0100
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140221081603.GA3931@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, Feb 20, 2014 at 04:38:10PM -0800, Bjorn Andersson wrote:
> +static int qup_i2c_probe(struct platform_device *pdev)
> +{

[ snip ]

> +
> +	qup_i2c_enable_clocks(qup);
> +

[ snip ]

> +
> +	pm_runtime_set_autosuspend_delay(qup->dev, MSEC_PER_SEC);
> +	pm_runtime_use_autosuspend(qup->dev);
> +	pm_runtime_enable(qup->dev);

Since the device is already woken up, you probably need to call
pm_runtime_set_active here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140221/d5be1f18/attachment.sig>
