From: jhovold@gmail.com (Johan Hovold)
Date: Thu, 31 Oct 2013 15:07:47 +0100
Subject: [PATCH 2/2] misc: atmel_pwm: set initcall level to subsys
In-Reply-To: <20131031053037.GA30542@ns203013.ovh.net>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
 <20131029232249.GA20476@kroah.com>
 <20131030110705.GA29813@localhost>
 <201310302146.18248.arnd@arndb.de> <5271B012.4060200@atmel.com>
 <20131031053037.GA30542@ns203013.ovh.net>
Message-ID: <20131031140747.GH29813@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 06:30:37AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:19 Thu 31 Oct     , Bo Shen wrote:
> > Hi Arnd,
> > 
> > On 10/31/2013 04:46, Arnd Bergmann wrote:
> > >On Wednesday 30 October 2013, Johan Hovold wrote:
> > >>>I really hate this type of patch, as it's papering over the real
> > >>>problem.  What happens when someone else moves their driver to this
> > >>>level?  Then you are back to the original problem.
> > >>
> > >>Yes, it's crude, but it's currently the only way to express a preferred
> > >>probe order.
> > >
> > >Does the same problem occur with the generic PWM subsystem?
> > >
> > >The atmel_pwm driver apparently is the last PWM driver that has
> > >not been converted to the generic subsystem yet. Doing that would
> > >also let us drop the atmel-pwm-bl driver in favor of the generic
> > >backlight.
> > 
> > The atmel pwm driver is on the way to generic subsystem. more
> > information at:
> > --->8---
> > PWM: atmel-pwm: add PWM controller driver:
> >    https://patchwork.kernel.org/patch/2963081/
> 
> so the fix can be drop in favor of the conversion

This patch (2/2) has been dropped, but the dependency issue still has to
be addressed (by adding deferred-probing support). The atmel-pwm-bl
driver has not been removed yet and the fix is also needed in stable.

Johan
