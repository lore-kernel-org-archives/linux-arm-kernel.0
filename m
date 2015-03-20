From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 20 Mar 2015 11:19:25 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <550B3725.10209@gmail.com>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana> <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana> <550B3725.10209@gmail.com>
Message-ID: <20150320101925.GC2071@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ok, I see what you mean. I had a look at the place in question and
> wonder what to return from i2c_add_mux_adapter() in the disabled
> case so that i2c-mux-pinctrl is still happy with the returned value.

Ouch, you are right. The crux of interfaces returning NULL instead of an
ERR_PTR :( I'll have a look, I maybe started to fix this somewhen.

> I guess what you want to have is that i2c_add_adapter() is not called
> for the disabled case, right?

I think that makes sense.

> Is the i2c_adapter struct prepared in i2c_mux_add_adapter() still valid
> if i2c_add_adapter() is not called?

I will have a closer look to the issue this weekend.

> Sorry, I am not too deep into i2c subsystem, I just reworked i2c-mux-
> pinctrl to make it work on Dove. If you are fine with giving me some
> guidance how you prefer to have it done, I can try to free some spare
> time.

Cool, thanks. Learning by doing is a good way to get such knowledge :)

> Unfortunately there is already little of it, so please don't
> expect a quick tested patch.

I understand.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150320/9241a8b2/attachment.sig>
