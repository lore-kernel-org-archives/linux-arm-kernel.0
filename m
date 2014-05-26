From: ydroneaud@opteya.com (Yann Droneaud)
Date: Mon, 26 May 2014 21:14:48 +0200
Subject: [PATCH 1/3] driver core/platform: don't leak memory allocated
 for dma_mask
In-Reply-To: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
References: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
Message-ID: <1401131688.18997.12.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emil,

Le lundi 26 mai 2014 ? 18:41 +0200, Emil Goode a ?crit :

> The first two patches in the series are created from v4 of the
> original patch, since I have not changed how the code works I think
> it is correct to keep the original author and Signed-off-by line.
> 
> Best regards,

Thanks for the update.

I wasn't interested in splitting the patch in two separate chunks,
thinking that shrinking the size of the structure then increasing it of
roughly the same amount was not the best way to sell the changes :)

Unfortunately, as noted by Uwe, you not only split the patch but also
broke it ;)

If we're going to split the patch, it should be split in:
1) replace name[1] by name[] (or name[0]) to remove the implicit padding
from platform_device structure
2) add dma_mask to platform_object structure and use it to initialize
   dev.dma_mask.

Anyway, as Russel explained in another mail, unconditionally set
dev.dma_mask pointer is probably going to break, so this part (2) need
some rework, I'm gonna try to do.

Thanks for reminding me about this patch.

Regards.

-- 
Yann Droneaud
OPTEYA
