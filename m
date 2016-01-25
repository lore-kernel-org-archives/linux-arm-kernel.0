From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:56:40 +0100
Subject: [PATCH 1/4] crypto: sunxi - don't print uninitialized data
In-Reply-To: <1453740845-1980433-1-git-send-email-arnd@arndb.de>
References: <1453740845-1980433-1-git-send-email-arnd@arndb.de>
Message-ID: <5143347.j0XTtrAXzs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 January 2016 17:53:48 Arnd Bergmann wrote:
> gcc correctly warns that the printk output contains a variable that
> is not initialized in some cases:
> 
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c: In function 'sun4i_ss_cipher_poll':
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:254:76: warning: 'todo' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:144:15: note: 'todo' was declared here
> 
> This adds an explicit initialization to zero in the exact case where it
> was missing, to avoid leaking stack data to the console and to shut up
> that warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 


Sorry for the broken ordering and missing cover letter. 
I just submitted three crypto patches:

[PATCH 1/4] crypto: sunxi - don't print uninitialized data
[PATCH] crypto: hash - select CRYPTO_HASH where needed
[PATCH 1/2] crypto: jitterentropy - always select CRYPTO_RNG

These address independent build issues, and there is no ordering between
them. None of them are important, so please queue them up for 4.6.

	Arnd
