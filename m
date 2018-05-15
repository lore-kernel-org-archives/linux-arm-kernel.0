From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 15 May 2018 08:28:56 +0200
Subject: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
In-Reply-To: <CAHp75Vdcd0MmqCMGkFXcvKLrzcHtxBDcB8U1qTzysaH9By4Y8A@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
 <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
 <CAHp75Vdcd0MmqCMGkFXcvKLrzcHtxBDcB8U1qTzysaH9By4Y8A@mail.gmail.com>
Message-ID: <f3caeaf5-a61b-bf28-2d4e-0dd4a76224c2@sorico.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/2018 18:56, Andy Shevchenko wrote:
> On Mon, May 14, 2018 at 1:57 PM, Richard Genoud
> <richard.genoud@gmail.com> wrote:
>> On 11/05/2018 12:38, Radu Pirea wrote:
>>> This patch modifies the place where resources and device tree properties
>>> are searched.
> 
>> I think it may be simpler with something like:
> 
>> +       int size = mfd_pdev->resource[0].end - mfd_pdev->resource[0].start + 1;
> 
> Isn't resource_size() macro for this very purpose?
Indeed.
+       int size = resource_size(mfd_pdev->resource);
would be even simpler !

> 
>>> +     int size = to_platform_device(pdev->dev.parent)->resource[0].end -
>>> +             to_platform_device(pdev->dev.parent)->resource[0].start + 1;
>>>
>> ditto
> 
> Ditto.
> 

Thanks !

Richard.
