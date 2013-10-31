From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 31 Oct 2013 06:30:37 +0100
Subject: [PATCH 2/2] misc: atmel_pwm: set initcall level to subsys
In-Reply-To: <5271B012.4060200@atmel.com>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
 <20131029232249.GA20476@kroah.com>
 <20131030110705.GA29813@localhost>
 <201310302146.18248.arnd@arndb.de> <5271B012.4060200@atmel.com>
Message-ID: <20131031053037.GA30542@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:19 Thu 31 Oct     , Bo Shen wrote:
> Hi Arnd,
> 
> On 10/31/2013 04:46, Arnd Bergmann wrote:
> >On Wednesday 30 October 2013, Johan Hovold wrote:
> >>>I really hate this type of patch, as it's papering over the real
> >>>problem.  What happens when someone else moves their driver to this
> >>>level?  Then you are back to the original problem.
> >>
> >>Yes, it's crude, but it's currently the only way to express a preferred
> >>probe order.
> >
> >Does the same problem occur with the generic PWM subsystem?
> >
> >The atmel_pwm driver apparently is the last PWM driver that has
> >not been converted to the generic subsystem yet. Doing that would
> >also let us drop the atmel-pwm-bl driver in favor of the generic
> >backlight.
> 
> The atmel pwm driver is on the way to generic subsystem. more
> information at:
> --->8---
> PWM: atmel-pwm: add PWM controller driver:
>    https://patchwork.kernel.org/patch/2963081/

so the fix can be drop in favor of the conversion

Best Regards,
J.
> ---<8---
> 
> Best Regards,
> Bo Shen
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
