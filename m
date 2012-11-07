From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Nov 2012 15:44:51 +0100
Subject: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
In-Reply-To: <20121107143046.GA4576@game.jcrosoft.org>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
 <20121107092124.GE12323@opensource.wolfsonmicro.com>
 <20121107104121.GG20063@game.jcrosoft.org>
 <20121107140535.GA28954@opensource.wolfsonmicro.com>
 <20121107143046.GA4576@game.jcrosoft.org>
Message-ID: <20121107144450.GF20844@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 03:30:46PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> the one via ASoC for the driver with the pinctrl for now but MUST add it later

> the arch/arm related via AT91 tree where the pinctrl is mandatory in the dtsi

> I'm no going to spend hours to do the pinctrl to test Bo patch that he is
> supposed to have deon to test this code

> As basically today on DT none of the board will work if BO does no provide the
> pinctrl so for me he MUST put in the dtsi

> is it ok with you?

Or add the pinmux bindings for other IPs over in the pinmux branch and
the pinmux binding for SSC here (which will help with bisection as the
DT bindings for the audio will then always exist in conjunction with the
.dtsi changes for them).  Either way is fine with me; I'll leave things
as they are until I see some new patches.

Though I have to say now that I look in -next it's a bit surprising that
there are so many IPs in the file that have no pinmix configuration,
based on what you're saying it seems like the entire board will be
falling over with the pinmux code anyway - in the case of the sam9g20ek
we'd at least need I2C pinmux settings.  I may be misunderstanding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/a6759dba/attachment.sig>
