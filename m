From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 12:23:29 +0000
Subject: [PATCH] ARM: ixp4xx: move fixed mapping of internal devices into
 vmalloc region
In-Reply-To: <1346996400-5824-1-git-send-email-gerg@snapgear.com>
References: <1346996400-5824-1-git-send-email-gerg@snapgear.com>
Message-ID: <201209071223.30275.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, gerg at snapgear.com wrote:
> 
> From: Greg Ungerer <gerg@uclinux.org>
> 
> The current fixed physical/virtual mappings for the internal peripherals
> of the ixp4xx SoC devices is using a virtual address outside of the vmalloc
> region. This results in kernel warnings like this on the boot console:
> 
>   BUG: mapping for 0xc8000000 at 0xffbeb000 out of vmalloc space
>   BUG: mapping for 0xc4000000 at 0xffbfe000 out of vmalloc space
>   BUG: mapping for 0xc0000000 at 0xffbff000 out of vmalloc space
> 
> The virtual kernel memory layout lists this for the vmalloc region:
> 
>     ...
>     vmalloc : 0xc2800000 - 0xff000000   ( 968 MB)
>     ...
> 
> With a little adjustment to the virtual address used we can map these
> internal devices in the vmalloc region.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Imre, Krzysztof: do you prefer to take this patch into a branch of yours
and send a pull request, or should we just apply it directly into arm-soc.
In the former case, can you provide an Ack?

	Arnd
