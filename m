From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 14 Nov 2014 22:25:53 +0900
Subject: [PATCH v4] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
In-Reply-To: <CAD=FV=XGjDZRBw7re8aRHdzNAq5cmtfpZ5RMdQ7o1CzbFMVXjw@mail.gmail.com>
References: <1414977633-3196-1-git-send-email-addy.ke@rock-chips.com>
 <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=XGjDZRBw7re8aRHdzNAq5cmtfpZ5RMdQ7o1CzbFMVXjw@mail.gmail.com>
Message-ID: <546602E1.3080800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 03:58 AM, Doug Anderson wrote:
> Addy,
> 
> On Tue, Nov 4, 2014 at 6:03 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
>> The bit of sdio interrupt is 16 in designware implementation,
>> but it is 24 on Rockchip SoCs.This patch add sdio_id0 for the
>> number of slot0 in the SDIO interrupt registers.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>> ---
>> Changes in v2:
>> - rebase on http://git.linaro.org/git/people/ulf.hansson/mmc.git, next branch
>> Changes in v3:
>> - Remove dts for sdio_id0, just replace this with 8, suggested by Doug
>> - Change to support all Rockchip Socs, suggested by Heiko
>> Changes in v4:
>> - use init-hook to set sdio_id0, suggested by Jaehoon
>>
>>  drivers/mmc/host/dw_mmc-rockchip.c | 10 ++++++++++
>>  drivers/mmc/host/dw_mmc.c          | 12 +++++++-----
>>  drivers/mmc/host/dw_mmc.h          |  2 ++
>>  include/linux/mmc/dw_mmc.h         |  3 +++
>>  4 files changed, 22 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> 

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung
