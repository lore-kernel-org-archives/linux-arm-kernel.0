From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 08 May 2012 16:47:29 +0300
Subject: [PATCH] ARM: imx6q: make ksz9021rn_phy_fixup depends on config
 of FEC
In-Reply-To: <1336483275-8610-1-git-send-email-richard.zhao@freescale.com>
References: <1336478520.23308.36.camel@sauron.fi.intel.com>
 <1336483275-8610-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336484849.23308.41.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-08 at 21:21 +0800, Richard Zhao wrote:
> Fix build error without choose fec driver.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Reported-by: Artem Bityutskiy <dedekind1@gmail.com>

> +#if defined(CONFIG_FEC) || defined(CONFIG_FEC_MODULE)

I think there is a nicer way of doing this, something like

#include <linux/kconfig.h>

if (IS_ENABLED(CONFIG_FEC)) {
}

and you do not need the #ifdef ugliness.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/fa5b32e3/attachment-0001.sig>
