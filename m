From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 13:46:48 +0300
Subject: [PATCH 2/4] Input: keypad: Add smsc ece1099 keypad driver
In-Reply-To: <1345545940-2232-3-git-send-email-sourav.poddar@ti.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-3-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120821104647.GU10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 21, 2012 at 04:15:38PM +0530, Sourav Poddar wrote:
> +static struct platform_driver smsc_driver = {
> +	.driver = {
> +		.name	= "smsc-keypad",
> +		.of_match_table = of_match_ptr(smsc_keypad_dt_match),
> +		.owner  = THIS_MODULE,
> +	},
> +	.probe		= smsc_probe,
> +	.remove		= smsc_remove,

one extra comment which I forgot. You probably should put your remove on
__devexit and add __devexit_p(smsc_remove) here.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/f3284b73/attachment.sig>
