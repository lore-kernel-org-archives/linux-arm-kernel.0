From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 17:12:46 +0100
Subject: [PATCH 2/2] arm64: dts: exynos: added mailbox node
In-Reply-To: <CABb+yY1rvozkGS34CHt8YEJqvGRXuHV09=AdS3=zQBx=DjFDCQ@mail.gmail.com>
References: <1395057839-23871-1-git-send-email-ks.giri@samsung.com>
 <201403191846.28563.arnd@arndb.de>
 <CABb+yY1rvozkGS34CHt8YEJqvGRXuHV09=AdS3=zQBx=DjFDCQ@mail.gmail.com>
Message-ID: <7073716.9YBOcHOu36@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014 21:39:56 Jassi Brar wrote:
> On Wed, Mar 19, 2014 at 11:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 17 March 2014, Jassi Brar wrote:
> 
> >>   Perhaps the mailbox controller driver should name its links as it
> >> wants. By how the remote works with the mailbox links, the client
> >> driver asks for a specific mailbox link (which maybe a hardcoded
> >> string in the driver or be gotten alongside other data via client's
> >> DT) ?
> >
> > I don't see why we should do it any different from the other bindings.
> > Let's just stick with mboxes/mbox-names or mailboxes/mailbox-names
> > if you prefer.
> >
> >>   IOW we can't have a generic API/DT-bindings that could get us
> >> reusable client drivers. But only common framework/code that would
> >> otherwise be duplicated by every platform.
> >
> > That is a major benefit though.
> > Also even if most drivers won't work across multiple platforms, there
> > is still a reasonable chance that /some/ drivers will.
> >
> It seems those /some/ drivers will have to work with everything same
> but the channel name (which the client could get from its DT node when
> the second platform appears).

Why would you ever have varying channel names? I would expect that
the name is always fixed in the binding of the client driver, like
we do for clocks or interrupts for instance.

	Arnd
