From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 11 Oct 2012 05:37:34 +0100
Subject: [PATCH 05/16] vfs: bogus warnings in fs/namei.c
In-Reply-To: <201210091307.19225.arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <20121008115116.GA9243@quack.suse.cz>
 <201210091227.46324.arnd@arndb.de>
 <201210091307.19225.arnd@arndb.de>
Message-ID: <20121011043734.GE2616@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 01:07:19PM +0000, Arnd Bergmann wrote:

> Update: I could actually reproduce the problem now, but it only happens when
> building with 'gcc -s' (i.e. CONFIG_CC_OPTIMIZE_FOR_SIZE). It does happen
> with both gcc-4.6 and with gcc-4.8, and on both x86-64 and ARM. An alternative
> patch that would also make it go away is the variant below, but I think that's
> even worse than the first version I suggested because it makes the binary
> output slightly worse by adding an unnecessary initialization when building with
> 'make -s'.

I can live with that, provided that you give it sane commit message and
your s-o-b.
