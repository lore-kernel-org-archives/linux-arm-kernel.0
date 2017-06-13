From: srishtishar@gmail.com (srishti sharma)
Date: Wed, 14 Jun 2017 03:15:11 +0530
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c:
 Fixed alignment to match open parenthesis.
In-Reply-To: <20170613144749.yn6z7yecumrfaayk@mwanda>
References: <1497042442-3620-1-git-send-email-srishtishar@gmail.com>
 <20170613130006.GA15978@kroah.com>
 <CAB3L5oxNorqu6_WiseTjkr7N9i-doy=_4gxtwonCVcxQA3Nfrw@mail.gmail.com>
 <20170613144749.yn6z7yecumrfaayk@mwanda>
Message-ID: <CAB3L5oysSGvLBycn2u=ZqEB2YawCCnuCsTY1pnUqpesU75y5dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 8:17 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Jun 13, 2017 at 08:07:14PM +0530, srishti sharma wrote:
>> On Tue, Jun 13, 2017 at 6:30 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Sat, Jun 10, 2017 at 02:37:22AM +0530, srishti sharma wrote:
>> >> Fixed alignment so that it matched open parenthesis.
>> >>
>> >> Signed-off-by: srishti sharma <srishtishar@gmail.com>
>> >> ---
>> >>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
>> >> index f484bb0..2148ed0 100644
>> >> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
>> >> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
>> >> @@ -105,7 +105,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
>> >>  }
>> >>
>> >>  static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
>> >> -                             struct snd_ctl_elem_value *ucontrol)
>> >> +                            struct snd_ctl_elem_value *ucontrol)
>> >>  {
>> >>       struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
>> >>       int changed = 0;
>> >
>> > This patch is corrupted and can not be applied :(
>>
>>
>> Why is this corrupted ?
>
> Try applying it with `git am`.  There should be space characters at the
> start of these lines but your email client deleted them:
>
>         struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
>         int changed = 0;
>
> Read Documentation/process/email-clients.rst
>
> regards,
> dan carpenter


Hello,

I tried applying it with ' git am ' and it was giving me this error:

fatal: corrupt patch at line XX

I think this was produced because of running ./scripts/cleanfile on the patch .
I was using this to fix trailing whitespaces . So, I used a different
method to remove them and didn't get that error.

But now when I run 'git am' I get a different error:

error: patch failed:
drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c:105

Why am I getting this error ?

Regards,
Srishti
