From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 27 Nov 2014 17:45:36 +0100
Subject: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <1417096856.12707.59.camel@mtksdaap41>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
 <20141124121555.GG3733@katana>
 <1417096856.12707.59.camel@mtksdaap41>
Message-ID: <20141127164536.GC5667@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I think there are now 3 drivers in my queue which are not fully I2C
> > compatible but more supporting the very minimum to, say, read an eeprom.
> > I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
> > think about ways how to communicate deficiencies like "only 255 byte" or
> > "only WRRD messages" to users of that I2C controller. This is most
> > likely not happening before 3.19. But assistance is very welcome.
> 
> Let's us know what we could help :)

I'll put you on CC once I have a draft. Then review, test, comment. That
would help, thanks!

> > I don't like this idea. If somebody wants to send 1 message with 600
> > bytes and we can't do this, we should simply say so. Sending 3 messages
> > is not the same.
> 
> Agreed. I think this should only happen when we know the device can
> support that.
> However, from our experience, many i2c devices do support it. Do you
> think it is OK to add a flag in i2c_msg(eg, I2C_M_ALLOW_SPLIT) and only
> do message split when this flag is on?

I think we only should report the error and the calling i2c client
driver should decide what to do. It will have better knowledge on how to
split the message and do this on its own.

> > What about Sascha's idea of using a pinctrl driver?
> 
> We are working on mt6397 pmic pinctrl driver. It depends on mt8135
> pinctrl driver [1] and pmic pwrap driver [2]. There are some discussion
> about pinctrl bindings, we'll send pmic pinctrl driver when that is
> settled.
> 
> Just to make it clear, the pinctrl driver only handle pin mux, we still
> need to set mediatek,have-pmic to send i2c data through pmic.

I have to admit that I don't know this level of detail yet. I might see
Sascha tomorrow, maybe we'll have a chance to talk about it.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/8bd8cc48/attachment-0001.sig>
