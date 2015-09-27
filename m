From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 27 Sep 2015 16:10:48 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <1540878.9slRi6Q7xb@wuerfel>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <CAKohpok0A3JRhVCabscfJGuhJerWmypsQnwdqJcmvBBWdpvPwQ@mail.gmail.com>
 <1540878.9slRi6Q7xb@wuerfel>
Message-ID: <1578470.DLzaBp4j3T@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, September 26, 2015 09:33:56 PM Arnd Bergmann wrote:
> On Saturday 26 September 2015 11:40:00 Viresh Kumar wrote:
> > On 25 September 2015 at 15:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > So if you allow something like debugfs to update your structure, how
> > > do you make sure there is the proper locking?
> > 
> > Not really sure at all.. Isn't there some debugfs locking that will
> > jump in, to avoid updation of fields to the same device?
> 
> No, if you need any locking to access variable, you cannot use the
> simple debugfs helpers but have to provide your own functions.
> 
> > >> Anyway, that problem isn't here for sure as its between two
> > >> unsigned-longs. So, should I just move it to bool and resend ?
> > >
> > > I guess it might be more convenient to fold this into the other patch,
> > > because we seem to be splitting hairs here.
> > 
> > I can and that's what I did. But then Arnd asked me to separate it
> > out. I can fold it back if that's what you want.
> 
> It still makes sense to keep it separate I think, the patch is clearly
> different from the other parts.

I just don't see much point in going from unsigned long to u32 and then
from 32 to bool if we can go directly to bool in one go.

Thanks,
Rafael
