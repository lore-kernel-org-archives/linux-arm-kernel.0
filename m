From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 14 Jun 2016 10:55:38 +0200
Subject: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
In-Reply-To: <20160614095826.3bbbfd26@bbrezillon>
References: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160517110005.GA26166@ulmo.ba.sec>
 <20160614095826.3bbbfd26@bbrezillon>
Message-ID: <20160614085538.GA24442@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 09:58:26AM +0200, Boris Brezillon wrote:
> Hi Thierry,
> 
> On Tue, 17 May 2016 13:00:05 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
> > On Tue, May 17, 2016 at 11:12:32AM +0200, Boris Brezillon wrote:
> > > The PWM device exposed by the HLCDC IP is configured with an inverted
> > > polarity by default. Registering the PWM chip with the normal polarity
> > > was not a problem before commit 42e8992c58d4 ("pwm: Add core
> > > infrastructure to allow atomic updates") because the ->set_polarity()
> > > hook was called no matter the current polarity state, but this is no longer
> > > the case.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic updates")  
> > 
> > That's not technically correct, because it's the driver that has the
> > bug. The core change merely exposes it. How about if I sort this into
> > the pwm-atomic branch and reword the commit message accordingly? That
> > way things should all stay bisectible.
> 
> I don't see this change in your branch. Do you want me to resend this
> fix after reworking the commit message?

I must have forgotten about it. I've applied it to my fixes branch now,
for which I plan on sending a pull request tomorrow.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160614/825f6223/attachment-0001.sig>
