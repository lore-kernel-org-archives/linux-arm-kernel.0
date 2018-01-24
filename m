From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Jan 2018 13:08:25 +0000
Subject: [PATCH] crypto: picoxcell - Fix error handling in spacc_probe()
In-Reply-To: <1516398795-9018-1-git-send-email-khoroshilov@ispras.ru>
References: <1516398795-9018-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <20180124130825.tjcywfbcdfikklfl@willow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Alexey!

On Sat, Jan 20, 2018 at 12:53:15AM +0300, Alexey Khoroshilov wrote:
> If clk_get() fails, device_remove_file() looks inappropriate.
> 
> The error path, where all crypto_register fail, misses resource
> deallocations.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Jamie Iles <jamie@jamieiles.com>
