From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 14 Jun 2017 07:09:43 +0200
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c:
 Fixed alignment to match open parenthesis.
In-Reply-To: <CAB3L5oysSGvLBycn2u=ZqEB2YawCCnuCsTY1pnUqpesU75y5dg@mail.gmail.com>
References: <1497042442-3620-1-git-send-email-srishtishar@gmail.com>
 <20170613130006.GA15978@kroah.com>
 <CAB3L5oxNorqu6_WiseTjkr7N9i-doy=_4gxtwonCVcxQA3Nfrw@mail.gmail.com>
 <20170613144749.yn6z7yecumrfaayk@mwanda>
 <CAB3L5oysSGvLBycn2u=ZqEB2YawCCnuCsTY1pnUqpesU75y5dg@mail.gmail.com>
Message-ID: <20170614050943.GC11953@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 03:15:11AM +0530, srishti sharma wrote:
> On Tue, Jun 13, 2017 at 8:17 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Tue, Jun 13, 2017 at 08:07:14PM +0530, srishti sharma wrote:
> >> On Tue, Jun 13, 2017 at 6:30 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > On Sat, Jun 10, 2017 at 02:37:22AM +0530, srishti sharma wrote:
> >> >> Fixed alignment so that it matched open parenthesis.
> >> >>
> >> >> Signed-off-by: srishti sharma <srishtishar@gmail.com>
> >> >> ---
> >> >>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> >> >> index f484bb0..2148ed0 100644
> >> >> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> >> >> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> >> >> @@ -105,7 +105,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
> >> >>  }
> >> >>
> >> >>  static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
> >> >> -                             struct snd_ctl_elem_value *ucontrol)
> >> >> +                            struct snd_ctl_elem_value *ucontrol)
> >> >>  {
> >> >>       struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
> >> >>       int changed = 0;
> >> >
> >> > This patch is corrupted and can not be applied :(
> >>
> >>
> >> Why is this corrupted ?
> >
> > Try applying it with `git am`.  There should be space characters at the
> > start of these lines but your email client deleted them:
> >
> >         struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
> >         int changed = 0;
> >
> > Read Documentation/process/email-clients.rst
> >
> > regards,
> > dan carpenter
> 
> 
> Hello,
> 
> I tried applying it with ' git am ' and it was giving me this error:
> 
> fatal: corrupt patch at line XX

Exactly.

> I think this was produced because of running ./scripts/cleanfile on the patch .

Why would you do that?  By doing that you corrupted the patch file :(

Just use the proper output of 'git format-patch' and all will be fine.

thanks,

greg k-h
