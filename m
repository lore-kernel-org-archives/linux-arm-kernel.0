From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Jan 2013 15:38:01 -0800
Subject: ERROR: "__aeabi_uldivmod" [drivers/pinctrl/pinctrl-single.ko]
 undefined!
In-Reply-To: <CACRpkdYd9br=9G7FvjbKCebfMjqX6xcL5Oge+07MPTNadPapKw@mail.gmail.com>
References: <20130111150001.GA23505@n2100.arm.linux.org.uk>
 <CACRpkdYd9br=9G7FvjbKCebfMjqX6xcL5Oge+07MPTNadPapKw@mail.gmail.com>
Message-ID: <20130111233801.GP14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130111 12:47]:
> On Fri, Jan 11, 2013 at 4:00 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > The above error happens in builds including pinctrl-single - the reason
> > is this, where resource_size_t may be 64-bit.
> >
> >                 gpio->range.pin_base = (r.start - pcs->res->start) / mux_bytes;
> >                 gpio->range.npins = (r.end - r.start) / mux_bytes + 1;
> >
> > This leads to a 64-bit division by an extended 64-bit, resulting in the
> > call to our (unimplemented) 64-bit-by-64-bit division routines.
> >
> > This needs fixing - you probably want to cast the difference down to an
> > 'unsigned' first, and also maybe check that it does fit in an unsigned
> > too?
> 
> Agreed, Haojian can you provide a tested patch for this?
> I think you added this code...
> 
> Tony: please check and ACK.

OK will check and ack.

Tony
