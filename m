From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 10 Oct 2015 16:47:45 +0900
Subject: [PATCH v3] i2c: s3c2410: enable RuntimePM before registering to
 the core
In-Reply-To: <1444461874-2841-1-git-send-email-wsa@the-dreams.de>
References: <1444461874-2841-1-git-send-email-wsa@the-dreams.de>
Message-ID: <5618C2A1.2030101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 10.10.2015 o 16:24, Wolfram Sang pisze:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, otherwise
> this will fail. While here, move drvdata, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Changes since v2: don't call runtime pm on adaper if it wasn't registered
> 
> Thanks to Krzysztof for testing!
> 
>  drivers/i2c/busses/i2c-s3c2410.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Works good. Error path seems to be working fine as well.

Tested on Odroid-XU3 Lite, on top of next-20151009.
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
