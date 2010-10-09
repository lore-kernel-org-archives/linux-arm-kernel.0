From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 03:45:16 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101008232539.GA28697@kroah.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
Message-ID: <AANLkTinPftsrc1uD+Fef2FV6PMit2twiAEzPr90YcBcG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/9 Greg KH <greg@kroah.com>:
> On Sat, Oct 09, 2010 at 12:04:51AM +0100, Russell King - ARM Linux wrote:
>> So, since this has been known about for six months to the day, I completely
>> fail to see how making this a warning instead will create the necessary
>> motivation for the issue to be addressed.
>
> I doubt that people even noticed that this was a problem.
>
> Unless you throw a run-time warning at them, or even better, break the
> build of their drivers, they will not notice.

The run-time warning is there, and at the same time the ioremap()
fails, but this has never been into any release (certainly not there
in .35).

IMO the vast majority of people only try to run final releases, and
they will only see the warning on .36. I don't think _all_ ARM users
are expected to follow every patch sent on the linux-arm-kernel
mailing list, nor to try the -rc series. In fact, I doubt many try the
final releases that closely, maybe one yes, one no.

-- 
Felipe Contreras
