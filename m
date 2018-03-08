From: guro@fb.com (Roman Gushchin)
Date: Thu, 8 Mar 2018 22:11:10 +0000
Subject: Build fails with SLOB in next
In-Reply-To: <20180308172849.GO5799@atomide.com>
References: <20180308172849.GO5799@atomide.com>
Message-ID: <6555B7D0-95F4-45E3-AF34-E75412718F33@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony!

As far as I know, it?s not fixed yet.
I?ll send a fix on Monday.
Sorry for the inconvenience.

Roman

Sent from my iPhone

> On 8 Mar 2018, at 20:29, Tony Lindgren <tony@atomide.com> wrote:
> 
> Hi,
> 
> Looks like commit 8b1747684ff8 ("dcache: account external names as
> indirectly reclaimable memory") caused build fail if SLOB is selected:
> 
> fs/dcache.c: In function '__d_free_external':
> fs/dcache.c:278:22: error: implicit declaration of function
> 'kmalloc_index'; did you mean 'kmalloc_ node'?
> [-Werror=implicit-function-declaration]
>        -kmalloc_size(kmalloc_index(bytes)));
>                          ^~~~~~~~~~~~~
> 
> Is this already fixed somewhere?
> 
> Regards,
> 
> Tony
