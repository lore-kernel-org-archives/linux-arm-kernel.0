From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 10:03:06 +0200
Subject: Problems with semaphores, mutexes, and atomic?
In-Reply-To: <BANLkTimwzhucvub7ZXymxt2H5xVq=MYPvw@mail.gmail.com>
References: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
	<BANLkTimDcPWOwEMxdZdPyJdYx7KLGZn2wg@mail.gmail.com>
	<BANLkTimwzhucvub7ZXymxt2H5xVq=MYPvw@mail.gmail.com>
Message-ID: <201106201003.06717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011 09:44:16 Dave Hylands wrote:
> On Mon, Jun 20, 2011 at 12:20 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
> > On Mon, Jun 20, 2011 at 9:39 AM, Dave Hylands <dhylands@gmail.com> wrote:
> >> Hi,
> >>
> >> I wrote a small test module to test semaphores, mutexes and atomic
> >> increments, and I've tested it with CONFIG_SMP=y with 1 and 2
> >> processors and with CONFIG_SMP disabled.
> >>
> >> My test code can be found here:
> >> http://svn.hylands.org/linux/test-mutex/test-mutex.c
> >> (it's about 133 lines long).
> > yout code is not complete, the DEFINE_SEMAPHORE and DEFINE_SEMAPHORE
> > definitions are missing
> 
> I don't follow. Line 7 & 8 has
> 
> DEFINE_MUTEX( lock );
> DEFINE_SEMAPHORE( sem_lock );
> 
> and line 19 has
> 
> DEFINE_SEMAPHORE( thread_wait );

DEFINE_SEMAPHORE needs another argument, your code won't compile.

You should basically never use semaphores anyway. In order to wait
for a kthread to finish, use kthread_stop(). Do not use a semaphore
when you want a mutex.

	Arnd
