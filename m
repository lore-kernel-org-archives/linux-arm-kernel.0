From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 23:09:03 +0200
Subject: [PATCH 15/21] thermal: cooling: avoid uninitialied used gcc
 warning
In-Reply-To: <CAC-25o_bmrZZ9n10cBE=ewO7Yr+FmgP2JTYJNr1y=V_9BgcyXQ@mail.gmail.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-16-git-send-email-arnd@arndb.de>
 <CAC-25o_bmrZZ9n10cBE=ewO7Yr+FmgP2JTYJNr1y=V_9BgcyXQ@mail.gmail.com>
Message-ID: <201304252309.03613.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 April 2013, edubezval at gmail.com wrote:
> Rui has merged a patch that removes this bogus compiler warning:
> http://git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/commit/?h=next&amp;id=4469b99743d296e24aefc5f8ed7df1bc9cfbbac8
> 
> Though, as not as elegant as your patch, it does the trick. :-)

Ok, works for me.

Looking at the patch however tells me that it has the potential to hide real
bugs if the code is ever changed to actually do an uninitialized access.
It's not very likely in this case, but I generally recommend not to add
any variables at declaration time unless the initialization is to a
meaningful value that the code later uses.

	Arnd
