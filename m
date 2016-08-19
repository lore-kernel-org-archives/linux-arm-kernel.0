From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 19 Aug 2016 17:43:36 +0200
Subject: [PATCH v6 1/7] power: act8945a_charger: Remove
 "battery_temperature"
In-Reply-To: <1471569215-6046-2-git-send-email-wenyou.yang@atmel.com>
References: <1471569215-6046-1-git-send-email-wenyou.yang@atmel.com>
 <1471569215-6046-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160819154336.e6etmygoxnxnngd6@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 19, 2016 at 09:13:29AM +0800, Wenyou Yang wrote:
> -	if (charger->battery_temperature && !(status & APCH_STATUS_TEMPDAT))
> +	if (status & APCH_STATUS_TEMPDAT)

This is still wrong. You removed the negation.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160819/2e26b177/attachment.sig>
