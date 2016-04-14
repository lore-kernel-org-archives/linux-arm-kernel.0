From: marex@denx.de (Marek Vasut)
Date: Thu, 14 Apr 2016 21:55:27 +0200
Subject: [PATCH RFT 0/5] iio: mxs-lradc: fix leak and implement PM ops
In-Reply-To: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <570FF5AF.7010801@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2016 05:48 PM, Stefan Wahren wrote:
> This patch series fix a memory leak and implements suspend/resume
> support for mxs-lradc.
> 
> Patch 1: fix the memory leak
> Patch 2-4: refactor mxs-lradc in order to prepare PM implementation
> Patch 5: implement suspend/resume support
> 
> These patches has been tested with i.MX23 and i.MX28 but without
> a touchscreen. I added only a bogus touchscreen in devicetree.
> 
> It would be nice if someone with a real touchscreen could test it.
> 
> Stefan Wahren (5):
>   iio: mxs-lradc: fix memory leak
>   iio: mxs-lradc: move TS config into suitable function
>   iio: mxs-lradc: move STMP reset out of ADC init
>   iio: mxs-lradc: disable only mapped channels in mxs_lradc_hw_stop
>   iio: mxs-lradc: implement suspend/resume support
> 
>  drivers/iio/adc/mxs-lradc.c |  116 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 82 insertions(+), 34 deletions(-)
> 

On M28EVK:

Tested-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
