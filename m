From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 18 Jul 2012 12:53:18 +0530
Subject: Devicetree: Initialization order of mmc block devices?
In-Reply-To: <5006571A.7060103@de.bosch.com>
References: <5006571A.7060103@de.bosch.com>
Message-ID: <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2012 11:56, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>
> Similar to [1] we have a device which has two mmc block devices connected:
> One external removable and a second internal hard wired one. Depending on
> the availability of the external removable mmc card at boot time, the
> internal hard wired device becomes mmcblk1 (external mmc card available ==
> mmcblk0) or mmcblk0 if the external one is not there. This order is given by
> the hardware.
>
> With older, non-DT kernels, we used the hack from [2] to control the
> initialization order and force the internal hard wired device to mmcblk0.
>
> Now, we are switching to a newer, DT based kernel. With a DT based kernel
> this hack doesn't seem to work an more.
>
> Any idea how we could influence the initialization order of the mmc block
> devices using a DT based kernel? Ensuring that the internal, hard wired mmc
> card is always mapped to mmcblk0?
>
Doesn't it work by simply by moving the "internal" element before
"external" in the array 'struct twl4030_hsmmc_info mmc[]' ?
