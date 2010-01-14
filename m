From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 14 Jan 2010 09:12:18 +0800
Subject: [PATCH - 2nd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <20100113155454.GC28292@n2100.arm.linux.org.uk>
References: <201001131730.24535.epeer@tmtservices.co.za>
	<20100113155454.GC28292@n2100.arm.linux.org.uk>
Message-ID: <f17812d71001131712i72e62565ob1afab8542efb966@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +static void __init capc7117_ide_init(void)
> > +{
> > + ? ? pxa3xx_mfp_write(MFP_PIN_GPIO76, 0xa0c0); ? ? ? /* EXT_IRQ3 */
>
> I'm not sure that pxa3xx_mfp_write is supposed to be used. ?Eric?
>

No, we don't. Having magic number there is really painful to
understand and maintain. I guess for the statement above, one
can easily write this in a pin config array with macro:

GPIO76_GPIO,    /* EXT_IRQ3 */
