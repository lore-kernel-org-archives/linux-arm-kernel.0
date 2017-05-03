From: joe@perches.com (Joe Perches)
Date: Wed, 03 May 2017 12:40:32 -0700
Subject: [PATCH] ARM: Fix __show_regs output timestamps
In-Reply-To: <20170503192310.GD22219@n2100.armlinux.org.uk>
References: <61817479ac8c4c6c8be702d2e2136fddac1b1821.1493228290.git.joe@perches.com>
 <20170503192310.GD22219@n2100.armlinux.org.uk>
Message-ID: <1493840432.22125.21.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-05-03 at 20:23 +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 26, 2017 at 10:39:49AM -0700, Joe Perches wrote:
> > Multiple line formats are not preferred as the second and
> > subsequent lines may not have timestamps.
> > 
> > Lacking timestamps makes reading the output a bit difficult.
> > This also makes arm/arm64 output more similar.
> > 
> > Previous:
> > 
> > [ 1514.093231] pc : [<bf79c304>]    lr : [<bf79ced8>]    psr: a00f0013
> > sp : ecdd7e20  ip : 00000000  fp : ffffffff
> > 
> > New:
> > 
> > [ 1514.093231] pc : [<bf79c304>]    lr : [<bf79ced8>]    psr: a00f0013
> > [ 1514.105316] sp : ecdd7e20  ip : 00000000  fp : ffffffff
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Hi Joe,
> 
> Could you put this in my patch system please, I'm unlikely to remember to
> apply it otherwise if not already there (massive email backlog.)
> 
> Thanks.

Rehi Russell.

Done,?and I had to lookup your "my patch system", even
though it was in your trailer, the email address of the
system wasn't listed until bullet point 8.

If you've the time to ask me to do this, it seems likely
you could have forwarded the original email to your patch
system yourself instead.

Also "patches at armlinux.org.uk" isn't mentioned at all in
either the documentation or MAINTAINERS.  Should it be?

btw: http://www.armlinux.org.uk/developer/patches/info.php
has many outdated references like:

    Once the 2.7 kernel opens, support for new features in the 2.6
    kernels will not be accepted unless similar support is also available
    for the 2.7 kernel.
