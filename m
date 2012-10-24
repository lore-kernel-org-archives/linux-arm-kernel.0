From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Oct 2012 21:58:19 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
Message-ID: <20121024185818.GB772@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 24, 2012 at 10:28:46AM -0700, Dmitry Torokhov wrote:
> > for more complex pinctrl use cases. These are my dogfood drivers ...
> > Most of these will request more than one state and switch the driver
> > between these different states at runtime, in these examples for power
> > saving there are states named "default", "sleep" and in the I2C driver
> > also "idle".
> > 
> > These examples are more typical to how the ux500 platform will
> > look, also the SKE input driver will move the devise to sleep/default
> > states but we need to merge PM code before we can do that.
> 
> I do not say that no drivers should ever touch pinctrl, just that most
> of them do not have to if you have other layers to the right thing for
> them.

It will be a much bigger mess. Some drivers don't need to care about
pinctrl because drivers/base handle it for them, while some others will
need a way to tell drivers/base "hey, don't touch pinctrl at all because
I know what I'm doing" and that has to happen before probe() too,
otherwise it's already too late and, according to what you suggest,
drivers/base will already have touched pinctrl. The only way I see would
be to add an extra "dont_touch_my_pins" field to every driver structure
in the kernel. Clearly what you say is nonsense.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121024/a0916399/attachment.sig>
