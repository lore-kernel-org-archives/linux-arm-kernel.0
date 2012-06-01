From: joe@perches.com (Joe Perches)
Date: Thu, 31 May 2012 19:54:51 -0700
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FC82D89.1040108@hp.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <20120528070336.GM3377@game.jcrosoft.org> <4FC82D89.1040108@hp.com>
Message-ID: <1338519291.9151.7.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-31 at 20:48 -0600, Thavatchai Makphaibulcboke wrote:
> On 05/28/2012 01:03 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > can we do not duplicate those functions?
> 
> Thanks J for the comment.  Unfortunately, there is no easy way to share
> files among different architectures' preboot environment.  We have the
> choices either to have each architecture define its own copies or the
> decompressor defines them.  I believe the former is preferable.  As
> Lasse also pointed out, this way any specific architecture could provide
> an architectural dependent optimized version, if it chooses to.

Maybe provide __weak default functions that
can be overridden by any arch that could
or wants to improve on the defaults.
