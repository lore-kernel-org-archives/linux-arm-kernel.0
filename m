From: thavatchai.makpahibulchoke@hp.com (Thavatchai Makphaibulcboke)
Date: Thu, 31 May 2012 20:48:41 -0600
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <20120528070336.GM3377@game.jcrosoft.org>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <20120528070336.GM3377@game.jcrosoft.org>
Message-ID: <4FC82D89.1040108@hp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2012 01:03 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:

> can we do not duplicate those functions?
> 
> Best Regards,
> J.

Thanks J for the comment.  Unfortunately, there is no easy way to share
files among different architectures' preboot environment.  We have the
choices either to have each architecture define its own copies or the
decompressor defines them.  I believe the former is preferable.  As
Lasse also pointed out, this way any specific architecture could provide
an architectural dependent optimized version, if it chooses to.

Thanks,
Mak.
