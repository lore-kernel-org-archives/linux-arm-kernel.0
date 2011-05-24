From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 May 2011 13:51:28 +0200
Subject: Updated mach-types update
In-Reply-To: <BANLkTi=esTs+gTxGqbZc+TJgcna5OtmWhA@mail.gmail.com>
References: <201105231652.28497.arnd@arndb.de>
	<201105231839.57083.arnd@arndb.de>
	<BANLkTi=esTs+gTxGqbZc+TJgcna5OtmWhA@mail.gmail.com>
Message-ID: <201105241351.28692.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 May 2011, Jaya Kumar wrote:

> Thanks for the feedback. I think this thread went from the specific
> case of this 2363, Wayland board into a broader discussion. I
> understand this is because of the arm subarch cleanup goals. To help
> people like me who aren't familiar with the details, could you
> elaborate on "can still add board files" and "the work that is
> required to remove them later". Do you mean I could still submit a
> patch like arch/arm/mach-mmp/wayland* and you'd be willing to take it,
> but with the expectation that it would be removed at a later date? Is
> the removal work to do with adding device tree support (I assume
> that's a bootloader task as well as a subarch/board support task)? I'm
> happy to help with what I can but I'm very slow. I'm even having
> trouble just getting mainline to boot on the board. [1]

Hi Jaya,

Our long-term goal is to replace all board files that are today written
in C with device tree files that describe a board independent of the kernel.

This clearly isn't happening over night and we need a lot of people to help
out with that. You can definitely submit a patch to add the board (if you
haven't already) and then we review it with the goal of finding a solution
that helps you get the board supported while at the same time making some
progress towards removing board files. What exactly that solution is depends
a lot on the contents of your board file and what the mmp maintainers think
of it.

I haven't seen the board code, so I could only guess that it will be one
of these:

* If your board is very simple, we can help make that board use
  the device tree to describe all devices on your board, so you don't
  need a board file, while other mmp boards still use it.

* If there is something particularly ugly that is shared with other
  mmp board files, I'd ask you to clean up the same wart in all mmp board
  files but add yours without further changes.

* If the new board file looks good but too complex to convert to
  device tree right away, you could choose an area that stands in
  the way of moving all mmp boards over to device tree, and create
  a binding for that area. One such area might be describing the
  mfp pin config in the device tree.

	Arnd
