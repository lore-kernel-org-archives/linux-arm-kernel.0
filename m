From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 16 Jan 2011 12:08:19 +0100
Subject: cannot fetch arm git tree
In-Reply-To: <20110116092315.GA27542@n2100.arm.linux.org.uk>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
Message-ID: <20110116110819.GG6917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jello,

On Sun, Jan 16, 2011 at 09:23:15AM +0000, Russell King - ARM Linux wrote:
> On Sun, Jan 16, 2011 at 10:28:55AM +0800, Jello huang wrote:
> > Dear Russell,
> > 
> > when i use git fetch,there arm some wrong with it.
> > 
> > jello at jello-laptop:~/git/russell/linux-2.6-arm$git pull
> > error: Unable to find 89e4d4b145bb7e73b4c45671a84b401a5d8694c1 under
> > http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
> > Cannot obtain needed blob 89e4d4b145bb7e73b4c45671a84b401a5d8694c1
> > while processing commit eda2e5dcc914b4d70f665443efc9780e89a5e5c1.
> > error: Fetch failed.
> > 
> > What is the wrong?
> 
> No idea.  The tree has the object file in one of its pack files:
> 
> | rmk at ZenIV:[linux-2.6-arm.git]:<1020> GIT_DIR=. git cat-file -p 89e4d4b145bb7e73b4c45671a84b401a5d8694c1|head
> | 
> |         List of maintainers and how to submit kernel changes
> | 
> | Please try to follow the guidelines below.  This will make things
> | easier on the maintainers.  Not all of these guidelines matter for every
> | trivial patch so apply some common sense.
> 
> and the pack info file lists all the pack files.  Maybe you have a hash
> collision on a pack file with your repository?
Probably you have a corrupted pack file.  Try renaming all packfiles
listed in
http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git/objects/info/packs
(i.e.
.git/objects/pack/pack-74405a23171b6debd894d4791e06956d6387022a.pack
etc.) and try refetching then.  This happend to me after Ctrl-Cing an
earlier git-fetch.  Git doesn't seem to handle that case.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
