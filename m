From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Tue, 22 Mar 2016 18:48:00 +0100
Subject: [PATCH] crypto: sun4i-ss: use spin_lock_irq{save|restore}
In-Reply-To: <1458662694-25527-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1458662694-25527-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <56F18550.7030201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/03/2016 17:04, LABBE Corentin a ?crit :
> The current sun4i-ss driver is subject to data corruption when
> ciphering/deciphering.
> It occurs randomly on end of handled data.
> No root cause have been found and the only way to remove it is to replace
> all spin_lock_bh by they irq counterparts.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Hello

I have made a huge spelling problem, and didn't added Fixes tag.
I will resend it.
Sorry for the noise.

Regards
