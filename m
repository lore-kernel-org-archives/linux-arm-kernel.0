From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Fri, 20 Feb 2015 07:37:16 -0200
Subject: [PATCH] [media] [kbuild] Add and use IS_REACHABLE macro
In-Reply-To: <5822078.VORY4BTfEj@wuerfel>
References: <6116702.rrbrOqQ26P@wuerfel> <14254005.QkaJhTuY5H@wuerfel>
 <54E5FBEA.1000005@suse.cz> <5822078.VORY4BTfEj@wuerfel>
Message-ID: <20150220073716.64560682@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, 20 Feb 2015 10:29:42 +0100
Arnd Bergmann <arnd@arndb.de> escreveu:

> On Thursday 19 February 2015 16:06:18 Michal Marek wrote:
> > > We have similar problems in other areas
> > > of the kernel. In theory, we could enforce the VIDEO_TUNER driver to
> > > be modular here by adding lots of dependencies to it:
> > > 
> > > config VIDEO_TUNER
> > >       tristate
> > >       depends on MEDIA_TUNER_TEA5761 || !MEDIA_TUNER_TEA5761
> > >       depends on MEDIA_TUNER_TEA5767 || !MEDIA_TUNER_TEA5767
> > >       depends on MEDIA_TUNER_MSI001  || !MEDIA_TUNER_MSI001
> > 
> > Nah, that's even uglier. I suggest to merge your IS_REACHABLE patch.
> > 
> 
> Ok, can I take this as an ack from your side to merge the
> include/linux/kconfig.h part of the patch through the linux-media
> tree?
> 
> I thought about splitting up the patch into two, but that would
> just make merging it harder because we'd still have the dependency.

It is likely better if I merge at the linux-media tree. This way,
we can avoid conflicts with those headers, if this is ok for
Marek.

Regards,
Mauro

> 
> 	Arnd
