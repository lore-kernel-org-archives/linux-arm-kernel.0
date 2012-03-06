From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 20:01:57 +0000
Subject: [PATCH] ARM: pxa: fix regulator related build fail in
 magician_defconfig
In-Reply-To: <1331063203-21188-1-git-send-email-paul.gortmaker@windriver.com>
References: <1331063203-21188-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20120306200156.GA19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 02:46:43PM -0500, Paul Gortmaker wrote:

>  static struct regulator_consumer_supply bq24022_consumers[] = {
>  	{
> -		.dev = &gpio_vbus.dev,
>  		.supply = "vbus_draw",

No, this isn't a good fix - it will break the user.  You need to replace
dev with the equivalent dev_name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/b2636232/attachment.sig>
