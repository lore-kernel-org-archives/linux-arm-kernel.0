From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jan 2013 19:22:13 +0000
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
In-Reply-To: <201301170850.43655.sfking@fdwdc.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <50F7E83E.8000105@uclinux.org> <201301170850.43655.sfking@fdwdc.com>
Message-ID: <201301171922.13432.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 January 2013, Steven King wrote:
> I haven't been keeping up with the kernel list of late, can someone point me 
> to what''s being discussed so I can see what were talking about here?

We are discussion about changes to the GPIO API, in particular about
adding a descriptor (i.e. pointer to struct) based interface to
replace integers as the primary key.

Any kind of change on this level is currently problematic because it
is basically impossible to tell which files are implementing the
current interface and would need to get changed along with changing
gpiolib. If everything goes through gpiolib, it's much easier
to make compatible extensions in one place.

Do you have any numbers about how much of a difference for your
platforms we are talking about at most?

	Arnd
