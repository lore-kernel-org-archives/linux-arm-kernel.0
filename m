From: mb@bu3sch.de (Michael =?ISO-8859-1?Q?B=FCsch?=)
Date: Wed, 06 Apr 2011 22:57:08 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <BANLkTi=x89+52cMeutOB7J--QQta+mX_wg@mail.gmail.com>
	(sfid-20110406_224259_263459_4DF85580)
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTinubrmryu=Bco5_AVcj_arn7SWZxw@mail.gmail.com>
	<op.vti9ote53ri7v4@arend-laptop>
	<BANLkTin-u=U_-cUH9oCco0LjEBuQmh4wag@mail.gmail.com>
	<BANLkTi=x89+52cMeutOB7J--QQta+mX_wg@mail.gmail.com>
	(sfid-20110406_224259_263459_4DF85580)
Message-ID: <1302123428.20093.6.camel@maggie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-04-06 at 22:42 +0200, Rafa? Mi?ecki wrote: 
> 2011/4/6 Rafa? Mi?ecki <zajec5@gmail.com>:
> > If we want to have two drivers working on two (different) cores
> > simultaneously, we will have to add trivial mutex to group core
> > switching with core operation (read/write).
> 
> With a little of work we could avoid switching and mutexes on no-host
> boards. MMIO is not limited to one core at once in such a case.

I don't think that this is a problem at all.
All that magic does happen inside of the bus I/O handlers.
Just like SSB does it.
