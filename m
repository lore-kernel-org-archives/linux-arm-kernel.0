From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 08:49:04 -0400
Subject: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
In-Reply-To: <505ADBE6.6080509@stericsson.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
 <505ADBE6.6080509@stericsson.com>
Message-ID: <20120920124903.GO17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 11:03:34AM +0200, Ola Lilja wrote:

> I still don't like this. It is the dai_link-struct that bothers me. We have
> "ux500-msp-i2s.1" as name of the platform AND the cpu_dai. The MSP I2S-block is
> not the platform and it is certainly not both platform and cpu-DAI at the same time.

> Mark: Did you have a solution for this? Couldn't we just put NULL on the
> platform_name instead?

No, having no platform driver means a direct device<->device link (like
baseband<->CODEC).  You could always register the platform with a -dma
added in the name or something, it'd be a bit more code but it'd work,
but the framework doesn't particularly care what you call these things.
