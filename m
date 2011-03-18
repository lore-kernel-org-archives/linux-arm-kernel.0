From: andy@warmcat.com (Andy Green)
Date: Fri, 18 Mar 2011 14:47:49 +0000
Subject: [RFC PATCH 2/5] OMAP2+: add cpu id register to MAC address helper
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C3B8670@dbde02.ent.ti.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
	<20110312225047.27728.1835.stgit@otae.warmcat.com>
	<201103180934.39997.arnd@arndb.de>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3B8670@dbde02.ent.ti.com>
Message-ID: <4D837095.5040307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2011 02:37 PM, Somebody in the thread at some point said:

Hi -

> [sp] This 'trick' has been tried earlier in u-boot. See:
>       http://www.mail-archive.com/u-boot at lists.denx.de/msg19915.html
>
>       I am also not sure whether DIE_ID would really be unique.

It doesn't actually need all the bits to be unique for this, just have a 
low probability of collision with a reasonable number of devices sharing 
the same network.

If there is not enough variation as it stands in the first 6 bytes of 
it, all the 128 bit ID can be xor'd together, use the other registers 
about die revision, hawkeye also xored in, etc.

I'll ask about what can be expected from this at TI.

-Andy
