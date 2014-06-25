From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 14:57:11 +0200
Subject: [PATCH v2 2/2] video: imxfb: Fix lcd_ops .set_power and .get_power
 on/off inversion
In-Reply-To: <20140625061611.GF15686@pengutronix.de>
References: <1403528839-31901-1-git-send-email-denis@eukrea.com>
 <1403528839-31901-2-git-send-email-denis@eukrea.com>
 <20140625061611.GF15686@pengutronix.de>
Message-ID: <53AAC727.60702@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 08:16 AM, Sascha Hauer wrote:
> You use IS_ERR_OR_NULL() here. imxfb_lcd_set_power uses IS_ERR(). One of
> both must be wrong.
Fixed by using IS_ERR_OR_NULL.

> You could reduce indentation by bailing out early:
>
> 	if (IS_ERR(fbi->lcd_pwr))
> 		return 0;
Fixed (with IS_ERR_OR_NULL).

Denis.
