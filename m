From: jacob.keller@gmail.com (Jacob Keller)
Date: Fri, 27 Aug 2010 09:17:10 -0700
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <4C77D804.9060500@gmx.net>
References: <363bd749a38d0b785d8431e591bf54c38db4c2d7.1281956490.git.richard.cochran@omicron.at>
	<AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>
	<20100817085324.GB3330@riccoc20.at.omicron.at>
	<1282090963.1734.97.camel@localhost>
	<20100818071942.GA4096@riccoc20.at.omicron.at>
	<1282176776.2865.100.camel@localhost.localdomain>
	<20100819055518.GA4084@riccoc20.at.omicron.at>
	<1282594125.3111.344.camel@localhost.localdomain>
	<20100827123849.GC11657@riccoc20.at.omicron.at>
	<20100827143844.646eccf6@lxorguk.ukuu.org.uk>
	<20100827143437.GB3293@riccoc20.at.omicron.at>
	<20100827160624.433b3374@lxorguk.ukuu.org.uk>
	<4C77D804.9060500@gmx.net>
Message-ID: <AANLkTimG+cMnGL=K9Cf1Xjhnh3HKyH3k-scXRHLQdh7Y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 27, 2010 at 8:06 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote

> > > system time bimble track a source makes sense just as with NTP but
> making
> > > it a new clock seems the wrong model extending a non-too-bright API
> when
> > > you can just put the time sources in a file tree.
> >
> > Don't get your meaning here, what did you mean by "file tree?"
>
> Something like
>
>        /sys/class/timesource/<name>/...
>
> at which point we don't have to enumerate them all, add special system
> calls and then fret about the fact you can't access them from things like
> shell scripts.
>

I agree that this interface is the best way to be future proof. This appears
to allow for multiple "clocks" or nodes, and doesn't get messed up when we
add more than one NIC with separate clocks to a machine.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100827/958e52ae/attachment-0001.html>
