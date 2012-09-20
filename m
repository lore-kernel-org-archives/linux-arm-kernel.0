From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 20 Sep 2012 12:04:31 +0200
Subject: [PATCH v2 1/2] watchdog: at91sam9_wdt: add device tree support
In-Reply-To: <20120920052834.GD17667@game.jcrosoft.org>
References: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
 <1348055861-7857-2-git-send-email-fabio.porcedda@gmail.com>
 <20120920052834.GD17667@game.jcrosoft.org>
Message-ID: <CAHkwnC92eMRs+FhzLG8_Y0JhKL8yVKVPhN2TSu7wTSRK6OSGuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 7:28 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 13:57 Wed 19 Sep     , Fabio Porcedda wrote:
>> Tested on an at91sam9260 board (evk-pro3)
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
>>  drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
>>  2 files changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> new file mode 100644
>> index 0000000..fca76fd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> @@ -0,0 +1,15 @@
>> +* Atmel Watchdog Timers
>> +
>> +** at91sam9-wdt
>> +
>> +Required properties:
>> +- compatible: must be "atmel,at91sam9-wdt"
> atmel,at91sam9260-watchdog
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +
>> +Example:
>> +
>> +     watchdog at fffffd40 {
>> +             compatible = "atmel,at91sam9-wdt";
>> +             reg = <0xfffffd40 0x10>;
>> +     };
>
> you need to be able to specify the timeout too via DT

Ok, i will send an updated patch.

Thanks for the review
-- 
Fabio Porcedda
