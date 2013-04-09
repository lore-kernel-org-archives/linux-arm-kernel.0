From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 09 Apr 2013 16:07:58 +0200
Subject: [PATCH/RFC] ARM: shmobile: Disallow PINCTRL without GPIOLIB
In-Reply-To: <CACRpkdZ9fSoQnF-MgRKi4PUhv56+CuraXhuVgUhLyHcoEnBPZg@mail.gmail.com>
References: <20130318135818.23765.51686.sendpatchset@w520>
 <21658140.49USZQOU99@avalon>
 <CACRpkdZ9fSoQnF-MgRKi4PUhv56+CuraXhuVgUhLyHcoEnBPZg@mail.gmail.com>
Message-ID: <2575027.16EVpHnJzT@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tuesday 09 April 2013 10:06:45 Linus Walleij wrote:
> On Tue, Mar 26, 2013 at 4:23 PM, Laurent Pinchart wrote:
> >> About this issue, the fact that selecting PINCTRL without GPIO results
> >> in compile error makes me think that something needs slight adjustment
> >> in the PFC code.
> > 
> > The above errors come from the pinctrl core (although the PFC driver might
> > not compile either in this case). Linus, what's your opinion on this ? Do
> > we want to support systems with pinctrl but without gpiolib ?
> 
> Yes. It is perfectly legal to have pin controllers that do not correlate
> GPIO ranges.
> 
> Does commit 2afe8229687ec24cbc07e78449a588bb8b68f858
> "pinctrl: core: add dependence of GPIOLIB"
> by Haojian fix this issue?

Yes it does.

I've just sent a patch that makes GPIOLIB support optional in the PFC driver. 
Magnus, with these two, should we revert 
6722f6cb763203cab775297b6e9d00834af0d6d7 ?

-- 
Regards,

Laurent Pinchart
