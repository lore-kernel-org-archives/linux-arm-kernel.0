From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Sep 2018 09:08:36 -0700
Subject: Regression in next with filesystem context concept
In-Reply-To: <11959.1536420266@warthog.procyon.org.uk>
References: <20180907161023.GF5662@atomide.com>
 <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <11959.1536420266@warthog.procyon.org.uk>
Message-ID: <20180910160836.GT5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* David Howells <dhowells@redhat.com> [180908 15:28]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > > > Looks like next-20180906 now has a regression where mounting
> > > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > > filesystem superblock creation/configuration context").
> > > 
> > > Am I right in thinking you're not using any of the LSMs?
> > 
> > Assuming LSM as in Documentation/lsm.txt, right not using any.
> 
> The default return value for security_fs_context_parse_param() should be
> -ENOPARAM, both in security.h and security.c.
> 
> I've fixed my tree and Al has pulled it, but we're now waiting on Stephen
> Rothwell to refresh linux/next.

OK thanks for tracking that down, next-20180910 boots again
for me.

Regards,

Tony
