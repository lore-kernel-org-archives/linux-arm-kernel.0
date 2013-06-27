From: joe@perches.com (Joe Perches)
Date: Thu, 27 Jun 2013 15:46:28 -0700
Subject: [PATCH v2] mm: module_alloc: check if size is 0
In-Reply-To: <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <20130627093917.GQ7171@linux-mips.org>
 <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org>
Message-ID: <1372373188.2060.32.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-27 at 15:23 -0700, Andrew Morton wrote:
> On Thu, 27 Jun 2013 11:39:17 +0200 Ralf Baechle <ralf@linux-mips.org> wrote:
[]
> Veli-Pekka's original patch would be neater if we were to add a new
> 
> void *__vmalloc_node_range_zero_size_ok(<args>)
> {
> 	if (size == 0)
> 		return NULL;

I believe you mean
		return ZERO_SIZE_PTR;
