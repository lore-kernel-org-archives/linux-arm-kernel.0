From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Nov 2018 11:01:14 +0100
Subject: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
In-Reply-To: <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <1391bbe1-75b5-c86e-ed3a-1e1afb393917@mleia.com>
Message-ID: <20181116100114.GB28631@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 11:22:49AM +0200, Vladimir Zapolskiy wrote:
> Hello Uwe,
> 
> On 11/16/2018 08:52 AM, Uwe Kleine-K?nig wrote:
> > Regarding the .request case: The consumer might be interested in taking
> > over the configured state from the boot loader. So the initially
> > configured state should be retained.
> > 
> > For the free case the PWM consumer is responsible to disable the PWM
> > before calling pwm_release and there are three subcases to consider:
> > 
> 
> the changes are fine per se, but please split them into two.
> 
> Probably pwm_disable() misusage began spreading from commit 54b2a999a1675.

It's not really misusage to call pwm_disable(). It's basically just a
shortcut for ->disable() or the atomic equivalent for it. So I think the
commit that you point to is doing exactly the right thing. Also note
that that commit was made 6 years ago, and a lot of things have changed
since then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/94ce7e09/attachment.sig>
