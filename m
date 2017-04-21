From: joe@perches.com (Joe Perches)
Date: Fri, 21 Apr 2017 13:56:24 -0700
Subject: [RFC PATCH 0/2] kbuild: use relative path from $(srctree)
 instead of __FILE__
In-Reply-To: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
References: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1492808184.30293.36.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-04-22 at 04:03 +0900, Masahiro Yamada wrote:
> Kbuild works in objtree, not in srctree.  So, __FILE__ is prefixed
> with $(srctree)/ for out-of-tree build.
> 
> It would be nice to see the same log regardless
> in-tree, or out-of-tree build.
> 
> 1/2 adds a new macro KBUILD_FILE.  This points the relative path
> of the file we are building.  This is intended to replace __FILE__.
> 
> 2/2 replaces __FILE__ in bug.h as an example.  This will improve
> the output of WARN_ON() etc.

Good idea.

Perhaps a lot of the in-tree __FILE__ uses should be
KBUILD_BASENAME or another new type like KBUILD_PRETTY_FILE
