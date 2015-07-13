From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 14 Jul 2015 00:27:54 +0530
Subject: [PATCH-v6 0/6] mfd: 88pm800: Add Device tree support
In-Reply-To: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436358392-15449-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <55A40A32.8060901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 08 July 2015 05:56 PM, Vaibhav Hiremath wrote:
> This patch-series adds support for Device tree to 88PM800 mfd driver.
> It also sets default configuration of irq clear method if board file
> doesn't exist.
>
> Testing::
>   - Boot tested on PXA1928 based platform.
>   - probe of mfd, rtc and regulator function passing successfully.
>   - Basic read operations on registers
>   - irq clear configuration
>
> V5 => V6
> =======

I hope this will be queued for 4.2

Thanks,
Vaibhav

> Link to V5: https://lkml.org/lkml/2015/6/29/283
>
>   - Added new patch to the series PATCH [1/6]
>     Cleanup patch to remove duplicate dev_err messages
>   - Added new patch to the series PACTH [3/6]
>     Cleanup patch to get pdata from 'device' pointer instead of
>     passing as a parameter.
>   - Removed irq_clr_mode/irq_mode field from 'struct pm80x_chip'
>     and use pdata.irq_clr_method to set irq clear method.
>   - Added acked-by and reviewed-by to respective patches.
>
> V4 => V5
> =======
> Link to V4: https://lkml.org/lkml/2015/6/25/67
>
>    - Renamed binding back again to 88pm800, as 'Yi Zhang' already started
>      submitting 88pm88x, so 88pm8xx won't make sense. Better name would be to
>      stick with 88pm80x.
>    - Added new patch to series PATCH 2/4, to remove unwanted protection around
>      padata
>    - As suggested by Lee, added macro based implementation for CLEAR_ON_WRITE
>      and CLEAR_ON_READ.
>    - and fixed other trivial comments.
>
> V3 => V4
> =======
> Link to V3: https://lkml.org/lkml/2015/6/24/143
>
>    -  irq clear method is 88PM800 feature, which is not dependent on board or
>       doesn't require any wiring changes, so DT is not the way.
>       Hardcoded to "irq clear on write" if board file doesn't exist.
>    - Updated binding patch (PATCH 3/3) to remove irq-clr-on-wr entry.
>    - Since PATCH 3/3 changed from original, removed Rob's Acked-by.
>
> V2 => V3
> =======
> Link to V2: https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg914299.html
>
>     - Replaced deprecated "regulator-compatible" property with "regulator-name".
>     - Added Rob's Acked-by  to [PATCH 3/3]
>
> V1 => V2
> =======
> Link to V1: http://lkml.iu.edu/hypermail/linux/kernel/1505.3/04386.html
>
>    - Split binding changes from original commit
>    - Updated binding info as per Rob's suggestion
>    - Dropped PATCH 4/4, as discussed during review
>    - Dropped PATCH 3/4, as it is independent RTC code change,
>      so will submit it separately to ease merging.
>    - Fixed all other minor comments
>
> Attempt has been made to push some of the patches to the list sometime
> back in 2013.
>
> Link to previous patch submission:
>          https://lkml.org/lkml/2013/8/14/86
>
>
> TODO:
> =====
>    - init config for 88PM860 device
>    - Rgulator driver changes to add support for 88PM860 device
>
>
>
> Vaibhav Hiremath (6):
>    mfd: 88pm800: remove duplicate dev_err calls during probe
>    mfd: 88pm800: Add device tree support
>    mfd: 88pm800: Get pdata from 'device' rather than passing as a
>      parameter
>    mfd: 88pm800: Remove unnecessary protection around pdata
>    mfd: 88pm800: Set default interrupt clear method
>    mfd: devicetree: bindings: Add new 88pm800 mfd binding
>
>   Documentation/devicetree/bindings/mfd/88pm800.txt |  53 ++++++++++
>   drivers/mfd/88pm800.c                             | 113 +++++++++++-----------
>   include/linux/mfd/88pm80x.h                       |   9 +-
>   3 files changed, 118 insertions(+), 57 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>
