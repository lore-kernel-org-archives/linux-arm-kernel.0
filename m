From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 25 Apr 2015 15:44:11 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <380631359.469897.1429964620007.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <380631359.469897.1429964620007.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Message-ID: <8220650.vMaWphVIuC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Am Samstag, 25. April 2015, 14:23:39 schrieb Stefan Wahren:
> > Heiko Stuebner <heiko@sntech.de> hat am 22. April 2015 um 22:53
> > geschrieben:
> > 
> > 
> > Using orphan clocks can introduce strange behaviour as they don't have
> > rate information at all and also of course don't track
> > 
> > [...]
> > 
> > 
> > As this changes the behaviour for orphan clocks, it would of course
> > benefit from more testing than on my Rockchip boards. To keep the
> > recipent-list reasonable and not spam to much I selected one (the topmost)
> > from the get_maintainer output of each drivers/clk entry.
> > Hopefully some will provide Tested-by-tags :-)
> 
> excuse me for my naive question, but what kind of tests do you expect
> (beside applying the patches)?

just a "everything that worked before still works" :-)

Using orphaned clocks should already produce strange issues most of the time - 
for example I see clk_disable mismatches when suspending a rk3288 board, 
before this patchset.

But nevertheless we now disallow the usage of orphaned clocks completely while 
before it was possible to knowingly/unknowingly use them.

And while hopefully most drivers should handle an EPROBE_DEFER from clk_get 
just fine, there may still be one or two lurking around that would need fixing 
then ;-)


Heiko
