From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 1 May 2017 14:44:07 +0800
Subject: [PATCH v2 02/30] pinctrl: mediatek: reuse pinctrl driver for
 mt7623
In-Reply-To: <CACRpkdbR-k3wgD+7KoV6d7yg1uduXpa9MO0+woEibQYPeYzgYw@mail.gmail.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
 <1493198774-4478-3-git-send-email-sean.wang@mediatek.com>
 <CACRpkdbR-k3wgD+7KoV6d7yg1uduXpa9MO0+woEibQYPeYzgYw@mail.gmail.com>
Message-ID: <1493621047.32195.4.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-04-28 at 10:01 +0200, Linus Walleij wrote:
> On Wed, Apr 26, 2017 at 11:25 AM,  <sean.wang@mediatek.com> wrote:
> 
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > mt7623 pinctrl driver can be compatible with mt2701 one,
> > so the patch reuses the driver and deletes those redundant
> > ones.
> >
> > Cc: John Crispin <john@phrozen.org>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> Partly correct.
> 
> >         "mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
> > -       "mediatek,mt7623-pinctrl", compatible with mt7623 pinctrl.
> 
> NO don't do this.
> 
> "compatible" means exactly this: this hardware is compatible with
> this driver. That is why we have it!
> 
> So instead of mt7623 pretending to be mt2701, let the mt2701 driver
> list that it is compatible with mt7623, simple.
> 
> So patch pinctrl-mt2701.c mt2701_pctrl_match[] instead.
> 

Hi Linus,

really appreciate your clear guidance and reviewing on this

I will fix it up in the next version
	
	Sean

> Yours,
> Linus Walleij
