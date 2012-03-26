From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Mar 2012 15:50:55 +0100
Subject: [PATCH] regmap: Add 24 bits support
In-Reply-To: <1332772808-13346-1-git-send-email-alexg@meprolight.com>
References: <1332772808-13346-1-git-send-email-alexg@meprolight.com>
Message-ID: <20120326145054.GV3098@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 04:40:08PM +0200, Alex Gershgorin wrote:
> This patch adds support for PMIC who use regmap and 24 bit registers
> For example MC13892, the patch was tested on i.MX35-PDK

A similar patch from Marc Reilly has already been applied.  You don't
have his signoff here but then...

> +typedef struct { __u8 b[3]; } __be24;

...you're adding stuff like this to the regmap headers which *clearly*
isn't regmap specific so this looks like a separate development.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120326/29610d5f/attachment.sig>
