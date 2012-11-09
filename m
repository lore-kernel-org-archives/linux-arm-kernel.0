From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 9 Nov 2012 12:19:28 +0100
Subject: [PATCH v2 04/10] pwm: pwm-tiecap: Add device-tree binding
 support for APWM driver
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9E44FC@DBDE01.ent.ti.com>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
 <1352361197-27442-5-git-send-email-avinashphilip@ti.com>
 <20121109075219.GA22224@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9E44FC@DBDE01.ent.ti.com>
Message-ID: <20121109111928.GA2391@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 10:59:30AM +0000, Philip, Avinash wrote:
> On Fri, Nov 09, 2012 at 13:22:19, Thierry Reding wrote:
> > On Thu, Nov 08, 2012 at 01:23:11PM +0530, Philip, Avinash wrote:
> > > +#define ECAPCLK_EN			BIT(0)
> > > +#define ECAPCLK_STOP_REQ	BIT(1)
> > 
> > This one doesn't seem to align with the rest. Also, why is bit 0 called
> > _EN and bit 1 _STOP_REQ? Couldn't they be made more consistent, i.e.
> > _START and _STOP? Or _ENABLE and _DISABLE?
> 
> Ok I will change to PWMSS_ECAPCLK_EN & PWMSS_ECAPCLK_STPO_REQ

While at it, maybe move these defines to the pwm-tipwmss.h header file?
After all that's the module that accesses the register that contains
these bits.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/20e39311/attachment.sig>
