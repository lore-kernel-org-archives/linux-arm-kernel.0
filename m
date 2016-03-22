From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 22 Mar 2016 19:55:32 +0300
Subject: [PATCH v5 1/6] of/serial: move earlycon early_param handling to
 serial
In-Reply-To: <CAL_JsqL+YU7qSze40c+M5AaOvpZDFgvg=SsRGmpT3k_=L6P8JQ@mail.gmail.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-2-git-send-email-aleksey.makarov@linaro.org>
 <CAL_JsqL+YU7qSze40c+M5AaOvpZDFgvg=SsRGmpT3k_=L6P8JQ@mail.gmail.com>
Message-ID: <56F17904.3070202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/22/2016 02:15 PM, Rob Herring wrote:
> On Tue, Mar 22, 2016 at 5:46 AM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> From: Leif Lindholm <leif.lindholm@linaro.org>
>>
>> We have multiple "earlycon" early_param handlers - merge the DT one into
>> the main earlycon one.  It's a cleanup that also will be useful
>> to decide if ACPI SPCR earlycon should be set up.
> 
> How so? Isn't that determined by whether we have ACPI tables or a DT?

Oops, I missed this.  This patch was not only to do parsing in one place, 
but also to allow addition of code that decide which of ACPI/DT should be used
for earlycon initialization based on acpi_disabled.

I will fix this, thank you.

> This goes against trying to limit places of FDT parsing and keeping
> the early scanning all within fdt.c. At least it is not in the arch
> code. That said, I'm okay with this change if it helps.
> 
> Rob
> 
