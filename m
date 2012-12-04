From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Dec 2012 09:14:17 +0000
Subject: [PATCH 1/1] gpio: Provide the STMPE GPIO driver with its own IRQ
 Domain
In-Reply-To: <CACRpkdbdCsx_SJvD9i+Geniy_McJb1dujzrSLu+o6bvcjUp_cw@mail.gmail.com>
References: <1353683949-9275-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdbdCsx_SJvD9i+Geniy_McJb1dujzrSLu+o6bvcjUp_cw@mail.gmail.com>
Message-ID: <20121204091417.GE2718@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 01 Dec 2012, Linus Walleij wrote:

> On Fri, Nov 23, 2012 at 4:19 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The STMPE GPIO driver can be used as an IRQ controller by some
> > related devices. Here we provide it with its very own IRQ Domain
> > so that IRQs can be issued dynamically. This will stand the
> > driver in good stead when it is enabled for Device Tree, as this
> > it a prerequisite.
> >
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> The patch looks bogus since there is no code exercising the added
> irqdomain code in this patch, it's basically a no-op in the irq
> path, which is wrong for an irqdomain.
> 
> It is lacking a irq_create_mapping() in stmpe_gpio_to_irq(),
> removal of the irq_base member and usage of
> irq_find_mapping() in stmpe_gpio_irq().
> 
> Only then will the irqdomain actually be used for what it's
> intended for.
> 
> So I get the impression that this is one of these "let's
> just throw a dummy irqdomain in there so we can use
> it with devicetree" kind of things...

It's not meant to be bogus, as it will be used.

Albeit, we are not uses of the GPIO functionality AFAICT.

I'll look at your comments in a bit and fixup.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
