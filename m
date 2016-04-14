From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 13:05:39 +0200
Subject: [PATCH v5 01/46] pwm: rcar: make use of pwm_is_enabled()
In-Reply-To: <20160412110152.GG18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110152.GG18882@ulmo.ba.sec>
Message-ID: <20160414130539.272166b0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry

On Tue, 12 Apr 2016 13:01:52 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Mar 30, 2016 at 10:03:24PM +0200, Boris Brezillon wrote:
> > Commit 5c31252c4a86 ("pwm: Add the pwm_is_enabled() helper") introduced a
> > new function to test whether a PWM device is enabled or not without
> > manipulating PWM internal fields.
> > Hiding this is necessary if we want to smoothly move to the atomic PWM
> > config approach without impacting PWM drivers.
> > Fix this driver to use pwm_is_enabled() instead of directly accessing the
> > ->flags field.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/pwm/pwm-rcar.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied, thanks.

I'd like to rebase my atomic series on top of pwm/for-next but I don't
see the 4 patches you said you applied. Did you forget to push
your local branch, or did you decide to revert them based on Lee's
comments?

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
