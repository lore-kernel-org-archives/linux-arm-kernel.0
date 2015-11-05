From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 5 Nov 2015 10:23:10 -0800
Subject: [PATCH] HID: hid-gfrm: avoid warning for input_configured API
 change
In-Reply-To: <alpine.LNX.2.00.1511041030420.22567@pobox.suse.cz>
References: <14835877.IL6ArpWV8Q@wuerfel>
 <CAGXr9JGO_dcAuTyO2vjvbBwJ7xqcEZ1kWh7WAtxaQiKsdzr1+A@mail.gmail.com>
 <20151103234802.GC29032@dtor-ws>
 <alpine.LNX.2.00.1511041030420.22567@pobox.suse.cz>
Message-ID: <20151105182310.GB36023@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 10:32:24AM +0100, Jiri Kosina wrote:
> On Tue, 3 Nov 2015, Dmitry Torokhov wrote:
> 
> > > > The input_configured callback was recently changed to return
> > > > an 'int', but the newly added driver uses the old API:
> > > >
> > > > drivers/hid/hid-gfrm.c:151:22: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > > >
> > > > This changes the driver like the other ones.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Acked-by: Petri Gynther <pgynther@google.com>
> > 
> > Hmm, the question is how to merge this, given that one change is in
> > Jiri's tree and another in mine...
> 
> In this case probably the best course of action is you cherry-picking 
> b2c68a2f1bab from my tree into yours, and proceeding further. git can 
> handle doubled commits (that will end up in Linus' tree eventually) 
> easily.
> 
> Another option would be to create a joint merge tree that'd contain both 
> branches merged together and proceed further from that, but I don't think 
> it's worth the hassle for simple case like this.
> 
> Works for you?

I went the cherry-pick route.

Thanks.

-- 
Dmitry
