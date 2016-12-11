From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 11 Dec 2016 15:59:01 +0100
Subject: [PATCH 3/3] mm: make pagoff_t type 64-bit
In-Reply-To: <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
 <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <2636242.RWRJivuddj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 11, 2016 6:26:42 PM CET Yury Norov wrote:
> Also fix related interfaces
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  fs/btrfs/extent_io.c       | 2 +-
>  fs/ext2/dir.c              | 4 ++--
>  include/linux/mm.h         | 9 +++++----
>  include/linux/radix-tree.h | 8 ++++----
>  include/linux/types.h      | 2 +-
>  lib/radix-tree.c           | 8 ++++----
>  mm/debug.c                 | 2 +-
>  mm/internal.h              | 2 +-
>  mm/memory.c                | 4 ++--
>  mm/mmap.c                  | 7 ++++---
>  mm/readahead.c             | 4 ++--
>  mm/util.c                  | 3 ++-
>  12 files changed, 29 insertions(+), 26 deletions(-)
> 

Thanks Yury for the demonstration. I think this would put the nail
in the coffin of the idea of mmap64 even for Pavel, who didn't
seem convinced already.

Changing all those interfaces and structure, struct page in particular,
is clearly too costly for any advantage we might have otherwise
gained.

	Arnd
