From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Wed, 23 Sep 2009 12:12:46 +0200
Subject: Problem in USB on the Sheevaplug, 2.6.31
In-Reply-To: <45219fb00909230247s65883755ia584b2e1e8c2369c@mail.gmail.com>
References: <45219fb00909230143h38db71e7l7c16b4a59ec1b152@mail.gmail.com>
	<20090923093543.GJ2558@darwin>
	<45219fb00909230247s65883755ia584b2e1e8c2369c@mail.gmail.com>
Message-ID: <20090923101246.GK2558@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Wed, Sep 23, 2009 at 11:47:52AM +0200 Llu?s Batlle ha dit:

> 2009/9/23, Matthias Kaehlcke <matthias@kaehlcke.net>:
> > hi lluis,
> >
> > the USB FAQ suggests it might be a problem of signal quality, try if it
> >  works when removing ehci-hcd:
> >  http://www.linux-usb.org/FAQ.html#ts6
> I have no cable between the board USB connector and the stick, and the
> Sheevaplug people claim to have good USB 2.0 support... I will see if
> it happens again.

ok

> >  is the file system subject to a lot of write accesses? in this case it
> Yes, I'm using it as /tmp, where I do builds. Kernel builds for
> example.

ouch, i don't think that's a good idea. i'd recommend using a
hard drive for stuff like this

> >  is likely you will encounter problems of corrupt sectors due to flash
> >  wear out. be sure not to mount locations like /var (especially
> I barely used that stick... and I trust Kingston so I think this is
> not the case.

flash sticks aren't designed for usage profiles with very frequent
writes, like kernel builds. i'd bet even a kingston one will have
problems in a near future if you use it in that way. have a look at
http://free-electrons.com/doc/flash-filesystems.pdf P. 29ff for more
information about the issue.

it's also recommended to use ext2 instead of ext3 to reduce wear out
produced by journalling

> >  /var/log) on the flash device. you also should mount the device with
> >  the options noatime and nodiratime if you aren't doing it yet
> I use noatime, but I didn't know of nodiratime.
> >
> >  <ca>per cert: que tal el sheeva plug? porto temps pensant de
> >  comprar-ne un</ca>
> <ca>Doncs n'estic ben content. Pel preu crec que est? molt b?. Hi he
> estat portant el NixOS, i no he fet cap compilaci? creuada, aix? que
> s'ho ha menjat tot el Sheevaplug. Per? fa nom?s un dia que utilitzo
> l'stick USB, abans ho feia tot amb nfsroot.</ca>

<ca>molt be allo del nixos, ets un friki de debo ;) jo encara funciono
amb un nslu2, pero va una mica just de recursos, per aixo m'estic
plantetjant el sheevaplug. per cert: t'havia comentat que el teu task
spooler va ser presentat a la versio impresa del <de>linux
magazin</de>?</ca>

-- 
Matthias Kaehlcke
Embedded Linux Engineer
Barcelona

        They that can give up essential liberty to obtain a little
           temporary safety deserve neither liberty nor safety
                         (Benjamin Franklin)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
