From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 08 Nov 2012 18:54:54 +0000
Subject: vexpress issues in next-20121029
In-Reply-To: <509AC63C.1070309@wwwdotorg.org>
References: <508EE610.9050703@wwwdotorg.org> <509AC63C.1070309@wwwdotorg.org>
Message-ID: <1352400894.20549.33.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-11-07 at 20:36 +0000, Stephen Warren wrote:
> On 10/29/2012 02:24 PM, Stephen Warren wrote:
> > 2) With those calls commented out, I find that
> > vexpress_sysreg_init_leds() is device_initcall, and so executes even
> > when not running on vexpress HW. This crashes on Tegra (which I have
> > converted to single-zImage locally).
> 
> This issue still appears to be present in next-20121107.

Yes, sorry about that - last week I've posted patches adding a generic
memory mapped leds driver and using it instead, but haven't managed to
get any comments from the maintainers. I've pinged them today and if I
hear nothing till tomorrow, I'll remove the offending code from
vexpress-sysreg.c completely and wait will this stuff till next cycle.

Pawe?
