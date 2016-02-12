From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 11 Feb 2016 19:19:07 -0800
Subject: [PATCH v5 RESEND 3/5] driver core: handle -EPROBE_DEFER from
 bus_type.match()
In-Reply-To: <1455101250-11327-4-git-send-email-m.szyprowski@samsung.com>
References: <1455101250-11327-1-git-send-email-m.szyprowski@samsung.com>
 <1455101250-11327-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20160212031907.GD10157@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 11:47:28AM +0100, Marek Szyprowski wrote:
> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> Allow implementations of the match() callback in struct bus_type to
> return errors and if it's -EPROBE_DEFER then queue the device for
> deferred probing.
> 
> This is useful to buses such as AMBA in which devices are registered
> before their matching information can be retrieved from the HW
> (typically because a clock driver hasn't probed yet).
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> [changed if-else code structure, adjusted documentation to match the code,
> extended comments]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/driver-model/porting.txt |  6 ++++--
>  drivers/base/dd.c                      | 24 ++++++++++++++++++++++--
>  include/linux/device.h                 |  7 +++++--
>  3 files changed, 31 insertions(+), 6 deletions(-)


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
