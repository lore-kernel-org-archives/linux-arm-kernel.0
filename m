From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 14:10:51 +0000
Subject: Question: how to make one page readonly on ARM
In-Reply-To: <CAADzPW34kLSCHrHiGkEY-erB01Sh_F-zPBSJafJXz+K2BWfjkw@mail.gmail.com>
References: <CAADzPW2bW8Rx+V726L+Mfji+-+rFxwwYO0nkKtgMTM0XtQ7BpQ@mail.gmail.com>
 <alpine.LFD.2.02.1202161329460.24536@xanadu.home>
 <CAADzPW34kLSCHrHiGkEY-erB01Sh_F-zPBSJafJXz+K2BWfjkw@mail.gmail.com>
Message-ID: <201202291410.51655.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 February 2012, ??? wrote:
> I just want to alloc some readonly pages to detect memory corruption.
> is it workable?

You could add a set_memory_ro function, but that will depend on another
patch to change the kernel mapping to 4k pages.

It's certainly possible to do, but will be a significant amount of work.

	Arnd
