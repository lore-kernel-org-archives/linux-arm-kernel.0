From: marcel@holtmann.org (Marcel Holtmann)
Date: Tue, 19 May 2015 19:39:01 +0200
Subject: [PATCH] mac802154: select CRYPTO when needed
In-Reply-To: <4189396.LhxDXkIPfr@wuerfel>
References: <4189396.LhxDXkIPfr@wuerfel>
Message-ID: <611EB56D-2A2D-4307-969F-6E7BEAEB597C@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> The mac802154 subsystem uses functions from the crypto layer and correctly
> selects the individual crypto algorithms, but fails to build when the
> crypto layer is disabled altogether:
> 
> crypto/built-in.o: In function `crypto_ctr_free':
> :(.text+0x80): undefined reference to `crypto_drop_spawn'
> crypto/built-in.o: In function `crypto_rfc3686_free':
> :(.text+0xac): undefined reference to `crypto_drop_spawn'
> crypto/built-in.o: In function `crypto_ctr_crypt':
> :(.text+0x2f0): undefined reference to `blkcipher_walk_virt_block'
> :(.text+0x2f8): undefined reference to `crypto_inc'
> 
> To solve that, this patch also selects the core crypto code,
> like all other users of that code do.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

patch has been applied to bluetooth-next tree.

Regards

Marcel
