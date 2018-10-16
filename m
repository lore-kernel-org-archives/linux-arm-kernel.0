From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 16 Oct 2018 11:06:09 +0200
Subject: [PATCH V3 1/2] dt-bindings: pinctrl: document Broadcom Northstar
 pin mux controller
In-Reply-To: <CACRpkdapyFnu=GAqEzK56+a5Gef+vcXsa7a6iJE=isi2MMWKTw@mail.gmail.com>
References: <20180926193103.21241-1-zajec5@gmail.com>
 <20181011222229.GA7470@bogus>
 <7f08ed7bf11a22163bdfd56ff96a9262@milecki.pl>
 <CACRpkdapyFnu=GAqEzK56+a5Gef+vcXsa7a6iJE=isi2MMWKTw@mail.gmail.com>
Message-ID: <CACna6rwLas5m9kX6YEgv4=2_qq2KuHsh3eNfd5Atbw4Adx8w4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Oct 2018 at 09:41, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Oct 15, 2018 at 10:56 AM Rafa? Mi?ecki <rafal@milecki.pl> wrote:
>
> > > Perhaps 'cru' in the compatible if that's what the h/w is called?
> > >
> > > Also, if this is a sub-block, then it should be a child of the block
> > > which should be defined here.
> >
> > It took me some time to do some extra research on the whole CRU thing.
> >
> > Valuable resources:
> > [1] bcm5301x_dmu.c (from the SDK)
> > [2] bcm5301x_pcie.c (from the SDK)
> > [3] https://patchwork.kernel.org/patch/7888651/
> > [4] https://patchwork.kernel.org/patch/5051471/
> >
> > First of all CRU seems to be a sub-block of the DMU (which stands for
> > "Device Management Unit" according to the [1]). DMU seems to be
> > independent block at 0x1800c000 with a size of 0x1000.
> >
> > It isn't actually clear what the CRU stands for. In Broadcom's case:
> > 1. According to the [3] it's "Clock and Reset Unit"
> > 2. According to the [4] it's a "central resource unit"
> > Other vendors seem to use CRU name for "Clock and Reset Unit".
> >
> > In any case, you're right Rob, it's a sub-block, a set of random
> > registers that control SoC.
> >
> > So I think that:
> > 1) We should have a node for DMU and CRU
> > 2) We should not include "cru" in bindings as pinmuxing seems to be part
> >     of SoC that just happens to be controlled using CRU registers
>
> OK do you want me to revert the patches or do you want to
> fix this stuff on top of the patches that are already in the tree?
> I'm fine either way.

I'm fine either way, thanks for taking care of my work!

-- 
Rafa?
