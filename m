From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 08 Oct 2014 08:59:46 +0900
Subject: [PATCH] mmc: dw_mmc: Reset DMA before enabling IDMAC
In-Reply-To: <CAD=FV=W-GW0c8m_5Oaet=ZhJJwmk4RWJ7QurcySB7T8YvKr6Sg@mail.gmail.com>
References: <1412618020-22278-1-git-send-email-sonnyrao@chromium.org>
 <CAD=FV=W-GW0c8m_5Oaet=ZhJJwmk4RWJ7QurcySB7T8YvKr6Sg@mail.gmail.com>
Message-ID: <54347E72.8010203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 10/07/2014 03:11 AM, Doug Anderson wrote:
> Sonny,
> 
> On Mon, Oct 6, 2014 at 10:53 AM, Sonny Rao <sonnyrao@chromium.org> wrote:
>> We've already got a reset of DMA after it's done.  Add one before we
>> start DMA too.  This fixes a data corruption on Rockchip SoCs which
>> will get bad data when doing a DMA transfer after doing a PIO transfer.
>>
>> We tested this on an Exynos 5800 with HS200 and didn't notice any
>> difference in sequential read throughput.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> 
