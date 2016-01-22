From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Jan 2016 17:52:45 +0100
Subject: [PATCH 0/5] crypto: atmel-sha: fix registration issue and other
 bugs
In-Reply-To: <cover.1452867917.git.cyrille.pitchen@atmel.com>
References: <cover.1452867917.git.cyrille.pitchen@atmel.com>
Message-ID: <56A25E5D.6050504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 15/01/2016 15:49, Cyrille Pitchen a ?crit :
> Hi all,
> 
> This series of patches fixes many issues such as the algo registration failure
> or the broken support of context switches.

I think it's eligible as a "fixes" series for 4.5... Herbert, is the
whole series can be queued as fixes, in your opinion?

And, on the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> This series was applied to linux-next and tested on a sama5d2 xplained
> ultra board. We now pass the tcrypt tests in the following modes:
> -  2: sha1
> -  6: sha256
> - 11: sha384
> - 12: sha512
> - 33: sha224
> 
> The context switch fix was tested with a userspace program using the cryptodev
> module. This single thread program computes the SHA256 hashes of many files
> by splitting then into fixed size chunks. The chunks of each file are
> processed by calling 'update' operations using a round robin algorithm.
> 
> However, the .import() / .export() implementation was NOT tested!
> Nonetheless the last patch is needed to fix the registration issue, otherwise
> atmel_sha_probe() would still fail.
> 
> Best regards,
> 
> Cyrille
> 
> 
> Cyrille Pitchen (5):
>   crypto: atmel-sha: fix crash when computing digest on empty message
>   crypto: atmel-sha: fix a race between the 'done' tasklet and the
>     crypto client
>   crypto: atmel-sha: add support of sama5d2x SoCs
>   crypto: atmel-sha: fix context switches
>   crypto: atmel-sha: fix algorihtm registration
> 
>  drivers/crypto/atmel-sha-regs.h |   4 +
>  drivers/crypto/atmel-sha.c      | 186 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 158 insertions(+), 32 deletions(-)
> 


-- 
Nicolas Ferre
