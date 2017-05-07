From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 7 May 2017 14:45:22 +0100
Subject: [PATCH 1/2] [PATCH 1/2] iio: adc: sun4i-gpadc-iio: Fix module
 autoload when PLATFORM devices are registered
In-Reply-To: <CAGb2v65Cgtxjhuj8v5A8RF8pGTK0FD3MDmDeirO4T_T7UCF4Vw@mail.gmail.com>
References: <20170501224559.21028-1-edu.molinas@gmail.com>
 <CAGb2v65Cgtxjhuj8v5A8RF8pGTK0FD3MDmDeirO4T_T7UCF4Vw@mail.gmail.com>
Message-ID: <a7956be3-3598-0290-8810-8434f62834e7@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/17 03:10, Chen-Yu Tsai wrote:
> On Tue, May 2, 2017 at 6:45 AM, Eduardo Molinas <edu.molinas@gmail.com> wrote:
>> If the driver is built as a module, it won't be autloaded if the devices
>> are registered via PLATFORM code because the PLATFORM device table
>> entries are not exported as aliases
>>
>> Before the patch:
>> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
>> $
>>
>> After th patch:
> 
>         ^^ the
> 
>> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
>> alias:          platform:sun6i-a31-gpadc-iio
>> alias:          platform:sun5i-a13-gpadc-iio
>> alias:          platform:sun4i-a10-gpadc-iio
>>
>> Signed-off-by: Eduardo Molinas <edu.molinas@gmail.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> Can we merge this as a fix for 4.12?
Applied to fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
