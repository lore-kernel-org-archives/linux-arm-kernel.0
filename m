From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 10 Apr 2013 19:44:25 +0200
Subject: [PATCH 2/2] ARM: at91: move dts to subdir
In-Reply-To: <5165A3BE.4070001@wwwdotorg.org>
References: <1365585444-11520-1-git-send-email-plagnioj@jcrosoft.com>
 <1365585444-11520-2-git-send-email-plagnioj@jcrosoft.com>
 <5165A3BE.4070001@wwwdotorg.org>
Message-ID: <20130410174425.GA20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:39 Wed 10 Apr     , Stephen Warren wrote:
> On 04/10/2013 03:17 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> A patch description might be nice.
> 
> This seems like a nice cleanup to keep the dts directory organized.
yeah I was really not a fan on the prefix stuff
> However, it does mean that the *.dtb files get moved again. I know that
> when they moved from boot/ to boot/dts/ in 3.9 (or 3.8?) there were some
> complaints that this made it difficult to write scripts that find the
> built DTB and copy it somewhere. This change would cause the exact same
> problem again.
yes this will move the dtb location to the subdir

> 
> Perhaps it's time to create an install_dtbs target to solve this problem?

I think about it too but was not sure if it will be usefull
as you may end with all the mach-xxx dtb generated and on embedded system you
do not want all of them on contrary on Ubuntu & co

I was also think to make it more generic so move the code to Kbuild
so any arch can use it
