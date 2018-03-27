From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 28 Mar 2018 00:30:48 +0200
Subject: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
In-Reply-To: <1520030090.8089.186.camel@mtkswgap22>
References: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
 <20180302105719.GC27178@ulmo>
 <1520030090.8089.186.camel@mtkswgap22>
Message-ID: <20180327223047.GG28163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2018 at 06:34:50AM +0800, Sean Wang wrote:
> On Fri, 2018-03-02 at 11:57 +0100, Thierry Reding wrote:
> > On Thu, Mar 01, 2018 at 04:19:12PM +0800, sean.wang at mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> > > control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> > > programming on PWM hardware causes waveform cannot be output as expected.
> > > Thus, the patch adds the extra condition for fixing up the weird case to
> > > let PWM4 or PWM5 able to work on MT7623.
> > > 
> > > v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> > > v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable
> > > 
> > > Cc: stable at vger.kernel.org
> > > Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Zhi Mao <zhi.mao@mediatek.com>
> > > Cc: John Crispin <john@phrozen.org>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
> > >  1 file changed, 21 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/13ef4738/attachment.sig>
