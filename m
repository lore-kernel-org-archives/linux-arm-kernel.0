From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 15:04:43 +0200
Subject: [PATCH v3 1/7] vfio: platform: introduce vfio-platform-base module
In-Reply-To: <1445603835-14506-2-git-send-email-eric.auger@linaro.org>
References: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
 <1445603835-14506-2-git-send-email-eric.auger@linaro.org>
Message-ID: <8949689.8EqFqDRsZI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 14:37:09 Eric Auger wrote:
> To prepare for vfio platform reset rework let's build
> vfio_platform_common.c and vfio_platform_irq.c in a separate
> module from vfio-platform and vfio-amba. This makes possible
> to have separate module inits and works around a race between
> platform driver init and vfio reset module init: that way we
> make sure symbols exported by base are available when vfio-platform
> driver gets probed.
> 
> The open/release being implemented in the base module, the ref
> count is applied to the parent module instead.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> 
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
