From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 13 Oct 2015 04:15:21 +0900
Subject: [PATCH v3] i2c: s3c2410: enable RuntimePM before registering
 to the core
In-Reply-To: <1444461874-2841-1-git-send-email-wsa@the-dreams.de>
References: <1444461874-2841-1-git-send-email-wsa@the-dreams.de>
Message-ID: <561C06C9.3090501@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/15 16:24, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, otherwise
> this will fail. While here, move drvdata, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Looks good to me,

Acked-by: Kukjin Kim <kgene@kernel.org>

Thanks,
Kukjin

> ---
> 
> Changes since v2: don't call runtime pm on adaper if it wasn't registered
> 
> Thanks to Krzysztof for testing!
> 
>  drivers/i2c/busses/i2c-s3c2410.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
