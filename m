From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 10 Apr 2014 10:22:34 +0200
Subject: [PATCH 4/4] arm: mediatek: Add earlyprintk support for MT6589
In-Reply-To: <CAL_JsqKq+D+c-qznP5aE3uyXf_YXyYzvoKRONAY7eXBkWcvqsw@mail.gmail.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <1397072736-10793-5-git-send-email-matthias.bgg@gmail.com>
 <CAL_JsqKq+D+c-qznP5aE3uyXf_YXyYzvoKRONAY7eXBkWcvqsw@mail.gmail.com>
Message-ID: <CABuKBeK9QE8ZGx1AKa9Cr9GLdHDKW-+NBirWs=uekqKxMP65EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-09 23:39 GMT+02:00 Rob Herring <robherring2@gmail.com>:
> On Wed, Apr 9, 2014 at 2:45 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>  arch/arm/Kconfig.debug            |   49 +++++++++++++++++++++++++++++++++++--
>>  arch/arm/include/debug/mediatek.S |   38 ++++++++++++++++++++++++++++
>>  2 files changed, 85 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm/include/debug/mediatek.S
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 4a2fc0b..dc51495 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -797,6 +797,38 @@ choice
>>                   Say Y here if you want kernel low-level debugging support
>>                   on Ux500 based platforms.
>>
>> +       config DEBUG_MTK6589_UART0
>> +               depends on ARCH_MEDIATEK
>> +               bool "Mediatek mt6589 UART0"
>> +               select DEBUG_UART_MEDIATEK
>> +               help
>> +                 Say Y here if you want kernel low-level debugging support
>> +                 on Mediatek mt6589 based platforms.
>> +
>> +       config DEBUG_MTK6589_UART1
>> +               depends on ARCH_MEDIATEK
>> +               bool "Mediatek mt6589 UART1"
>> +               select DEBUG_UART_MEDIATEK
>> +               help
>> +                 Say Y here if you want kernel low-level debugging support
>> +                 on Mediatek mt6589 based platforms.
>> +
>> +       config DEBUG_MTK6589_UART2
>> +               depends on ARCH_MEDIATEK
>> +               bool "Mediatek mt6589 UART2"
>> +               select DEBUG_UART_MEDIATEK
>> +               help
>> +                 Say Y here if you want kernel low-level debugging support
>> +                 on Mediatek mt6589 based platforms.
>> +
>> +       config DEBUG_MTK6589_UART3
>> +               depends on ARCH_MEDIATEK
>> +               bool "Mediatek mt6589 UART3"
>> +               select DEBUG_UART_MEDIATEK
>> +               help
>> +                 Say Y here if you want kernel low-level debugging support
>> +                 on Mediatek mt6589 based platforms.
>> +
>
> Do you really need all uarts defined? Only define what you have boards using.
>
> Also, you have no uarts defined in your dts. Please add them there
> (and any necessary serial driver) before adding debug functionality.
> Otherwise, you can't actually boot a multi-platform kernel with this
> series.

Up to now, there no serial driver exists. Should I skip this patch and
re-submit it when the serial driver is integrated?


-- 
motzblog.wordpress.com
