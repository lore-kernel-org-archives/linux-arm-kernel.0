From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 14 May 2018 19:56:47 +0300
Subject: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
In-Reply-To: <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
 <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
Message-ID: <CAHp75Vdcd0MmqCMGkFXcvKLrzcHtxBDcB8U1qTzysaH9By4Y8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 1:57 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:
> On 11/05/2018 12:38, Radu Pirea wrote:
>> This patch modifies the place where resources and device tree properties
>> are searched.

> I think it may be simpler with something like:

> +       int size = mfd_pdev->resource[0].end - mfd_pdev->resource[0].start + 1;

Isn't resource_size() macro for this very purpose?

>> +     int size = to_platform_device(pdev->dev.parent)->resource[0].end -
>> +             to_platform_device(pdev->dev.parent)->resource[0].start + 1;
>>
> ditto

Ditto.

-- 
With Best Regards,
Andy Shevchenko
