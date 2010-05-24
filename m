From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 22:00:50 +0100
Subject: [PATCH v3 11/14] omap: mailbox: only compile for configured archs
In-Reply-To: <AANLkTim7Jxlx3Owyn2IM_TjUWxS72I7h9H5d0evbCsVQ@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-12-git-send-email-felipe.contreras@gmail.com>
	<20100524.174205.22049047.Hiroshi.DOYU@nokia.com>
	<AANLkTim7Jxlx3Owyn2IM_TjUWxS72I7h9H5d0evbCsVQ@mail.gmail.com>
Message-ID: <20100524210050.GG21117@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 10:29:01PM +0300, Felipe Contreras wrote:
> On Mon, May 24, 2010 at 5:42 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
> 
> >> +     if (false);
> >
> > nitpcik:
> > The above may look better as below:
> >
> > ? ? ? ?if (false)
> > ? ? ? ? ? ? ? ?;
> >
> > "checkpatch.pl" also doesn't complain.
> 
> Personally I think it looks weird and it's a checkpatch bug, but fine by me.

No, I'd say it's intentional.

	if (false);

looks too much like an error - think about:

	if (false);
		do_something();

which would be very easy to miss while reviewing.
