From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 1 Jun 2011 14:45:55 +0200
Subject: [PATCH 0/3] Fixes for breakage resulting from syscore_ops patch
	=?iso-8859-1?q?on=09s3c24xx?=
In-Reply-To: <4DE62CEF.80507@embtoolkit.org>
References: <201106011348.47145.heiko@sntech.de>
	<4DE62CEF.80507@embtoolkit.org>
Message-ID: <201106011445.59798.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 01 Juni 2011 schrieb Abdoulaye Walsimou GAYE:
> Heiko St?bner wrote:
> > The syscore_ops patch from Rafael J. Wysocki introduced some small
> > glitches for the S3C24XX cpus resulting in compile errors.
> 
> I submitted same patches days ago [1],
> [1]
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/117812/focus=117814

irq-pm.c also was my initial target for s3c24xx_irq_syscore_ops, but it's only 
compiled when CONFIG_PM is set, where s3c24xx_irq_syscore_ops is always needed 
and its member-functions are set to null in pm.h when CONFIG_PM is not set

Heiko
