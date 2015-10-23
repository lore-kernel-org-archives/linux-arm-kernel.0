From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Oct 2015 09:43:47 -0700
Subject: [PATCH 08/13] clk: add ARM syscon ICST device tree bindings
In-Reply-To: <CACRpkdbXLs7hP=8WH6uK_3mQQEy4Y6TJsjpt4=LpeT=jmF-9Kw@mail.gmail.com>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-9-git-send-email-linus.walleij@linaro.org>
 <20151015192325.GN4558@codeaurora.org>
 <CACRpkdbXLs7hP=8WH6uK_3mQQEy4Y6TJsjpt4=LpeT=jmF-9Kw@mail.gmail.com>
Message-ID: <20151023164347.GB19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23, Linus Walleij wrote:
> On Thu, Oct 15, 2015 at 9:23 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 10/15, Linus Walleij wrote:
> 
> >> +Required properties:
> >> +- lock-offset: the offset address into the system controller where the
> >> +  unlocking register is located
> >> +- vco-offset: the offset address into the system controller where the
> >> +  ICST control register is located (even 32 bit address)
> >
> > Is there any reason why we don't use a reg property for this?
> 
> Usually reg = <> is used with two (or more) tokens:
> 
> reg = <phys_addr size>;
> 
> The exception being things like I2C addresses which
> are just one token.
> 
> Since in this case, there is a "mother" reg property in the
> syscon-compatible node, which we are indexing into,
> it is confusing to use the same name for subnodes.
> 
> Also there is a bunch of precedents doing it like this
> for sybdevices to system controllers, just
> git grep offset Documentation/devicetree/bindings
> will give you a bunch of them.
> 

Ok. I'm no DT expert, but it seems odd to have subnodes without a
reg property.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
