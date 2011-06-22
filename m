From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2011 15:05:32 +0200
Subject: [RFC 0/8] Introducing a generic AMP/IPC framework
In-Reply-To: <BANLkTim1kN2f41Cfz70=g4a_+gPPrWDacA@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<201106211620.02065.arnd@arndb.de>
	<BANLkTim1kN2f41Cfz70=g4a_+gPPrWDacA@mail.gmail.com>
Message-ID: <201106221505.32531.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2011, Ohad Ben-Cohen wrote:
> > One point I noticed is the use of debugfs, which you should probably
> > replace at some point with a stable API, e.g. your own debugfs-like
> > file system, but there is no hurry to do that now.
> 
> debugfs is only being used to expose debugging info (namely the power
> state of the remote processor and its trace log messages), which is
> mostly useful for developers trying to understand what went wrong.
> 
> It seems like debugfs fits quite nicely here (e.g. it's perfectly fine
> if this is completely compiled out on production systems), but sure,
> we can always revisit this later too.

Ok, I see. In that case I agree that using debugfs is fine, but I would
recommend trying to use fewer macros and just open-coding the file
operations for better readability.

> > Unfortunately require __packed. It would be better to sort the members
> > differently so that each member is naturally aligned in order to
> > avoid the need for padding or __packed attributes
> 
> Definitely. __packed is being used just to be on the safe side; we
> didn't intend to introduce unnatural alignment intentionally. will be
> fixed.

Ok.

	Arnd
