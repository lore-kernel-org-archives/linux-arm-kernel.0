From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 10 Oct 2017 11:12:42 +0300
Subject: [PATCH v4 0/5] media: atmel-isc: Rework the format list and
 clock provider
In-Reply-To: <20171010024640.5733-1-wenyou.yang@microchip.com>
References: <20171010024640.5733-1-wenyou.yang@microchip.com>
Message-ID: <20171010081242.jxoyb3i5hr5q6zkg@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 10:46:35AM +0800, Wenyou Yang wrote:
> To improve the readability of code, rework the format list table,
> split the format array into two. Meanwhile, fix the issue of the
> clock provider operation and the pm runtime support.
> 
> Changes in v4:
>  - Call pm_runtime_get_sync() and pm_runtime_put_sync() in ->prepare
>    and ->unprepare callback.
>  - Move pm_runtime_enable() call from the complete callback to the
>    end of probe.
>  - Call pm_runtime_get_sync() and pm_runtime_put_sync() in
>    ->is_enabled() callbacks.
>  - Call clk_disable_unprepare() in ->remove callback.
> 
> Changes in v3:
>  - Fix the wrong used spinlock.
>  - s/_/- on the subject.
>  - Add a new flag for Raw Bayer format to remove MAX_RAW_FMT_INDEX define.
>  - Add the comments for define of the format flag.
>  - Rebase media_tree/master.
> 
> Changes in v2:
>  - Add the new patch to remove the unnecessary member from
>    isc_subdev_entity struct.
>  - Rebase on the patch set,
>         [PATCH 0/6] [media] Atmel: Adjustments for seven function implementations
>         https://www.mail-archive.com/linux-media at vger.kernel.org/msg118342.html
> 
> Wenyou Yang (5):
>   media: atmel-isc: Add spin lock for clock enable ops
>   media: atmel-isc: Add prepare and unprepare ops
>   media: atmel-isc: Enable the clocks during probe
>   media: atmel-isc: Remove unnecessary member
>   media: atmel-isc: Rework the format list
> 
>  drivers/media/platform/atmel/atmel-isc-regs.h |   1 +
>  drivers/media/platform/atmel/atmel-isc.c      | 629 ++++++++++++++++++++------
>  2 files changed, 498 insertions(+), 132 deletions(-)

Thanks for the update!!

For patches 0--4:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
