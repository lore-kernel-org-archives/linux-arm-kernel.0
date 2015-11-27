From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 27 Nov 2015 15:06:14 +0100
Subject: [PATCH] mm, page_owner: only track migration if enabled
In-Reply-To: <3209032.Njpu4mxStH@wuerfel>
References: <3209032.Njpu4mxStH@wuerfel>
Message-ID: <56586356.3030308@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2015 02:58 PM, Arnd Bergmann wrote:
> The newly added code to print page ownership in dump_page fails
> to link when CONFIG_MIGRATION is disabled:
>
> mm/built-in.o: In function `print_page_owner':
> frame_vector.c:(.text+0x72358): undefined reference to `migrate_reason_names'
>
> This changes the two users of migrate_reason_names to first check
> CONFIG_MIGRATION, which avoids the error.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cf7ec391dae4 ("mm, page_owner: dump page owner info from dump_page()")
> ---
> Found on yesterday's linux-next with ARM randconfig builds. The patch
> that introduced this is currently in Andrews tree.
>
> If you don't already have a fix, please apply this one on top, or fold
> it into the original commit.

Thanks. I posted a different one yesterday:
http://marc.info/?l=linux-mm&m=144853435200591&w=2
