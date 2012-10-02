From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 2 Oct 2012 13:15:33 +0100
Subject: [PATCH 08/10] ARM: ux500: Stop calling the UIB init function
 when using Device Tree
In-Reply-To: <CACRpkdaM1SxcrAn086W+b-oC+k6w=SEhxq0CGqrA_4iXmgfWYA@mail.gmail.com>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
 <1349165603-24401-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdaM1SxcrAn086W+b-oC+k6w=SEhxq0CGqrA_4iXmgfWYA@mail.gmail.com>
Message-ID: <20121002121533.GA26783@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 02 Oct 2012, Linus Walleij wrote:

> On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > As there will be a Device Tree created for the UIBs, there is no
> > need to call the UIB initiation functions. Each device will be
> > detailed and registered from the Device Tree instead.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by, but...
> 
> > -       .init_late      = ux500_init_late,
> > +       .init_late      = NULL,
> 
> Why even define it?

More to show that we're _intentionally_ not using it.

I'm happy to remove if it offends you? :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
