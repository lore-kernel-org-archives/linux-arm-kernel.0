From: broonie@kernel.org (Mark Brown)
Date: Sun, 12 Jan 2014 19:20:40 +0000
Subject: [PATCH RFC 01/10] ARM: s3c64xx: pm: Use name field of
 generic_pm_domain
In-Reply-To: <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140112192040.GU29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 08:42:43PM +0100, Tomasz Figa wrote:

>  static struct s3c64xx_pm_domain s3c64xx_pm_irom = {
> -	.name = "IROM",
>  	.ena = S3C64XX_NORMALCFG_IROM_ON,
>  	.pd = {
> +		.name = "domain_irom",

This is nitpicking a bit but are you sure this is actually a
beautification of the name?  It's mainly the domain_ bit, mostly since
I'd expect that if it's not obvious that this is a power domain the core
logging would be changed rather than tweaking the name of every power
domain user.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140112/f96ea494/attachment.sig>
