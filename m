From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 27 Jan 2017 10:55:07 +0100
Subject: [PATCH v6 05/14] ARM: davinci: da850: add con_id for the SATA
 clock
In-Reply-To: <645778dd-6727-abd0-3dd9-a7e0d5aa4983@ti.com>
References: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
 <1485190856-4711-6-git-send-email-bgolaszewski@baylibre.com>
 <93a3bbb3-2d9f-bc38-c7b4-5eb3325d985d@ti.com>
 <645778dd-6727-abd0-3dd9-a7e0d5aa4983@ti.com>
Message-ID: <CAMpxmJXq-XZBhO3j=bHpfU2QjJ+6kiYcozS7-pVu3W4juNTVBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-26 18:40 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Thursday 26 January 2017 10:26 PM, Grygorii Strashko wrote:
>>
>>
>> On 01/23/2017 11:00 AM, Bartosz Golaszewski wrote:
>>> The ahci-da850 SATA driver is now capable of retrieving clocks by
>>> con_id. Add the connection id for the sysclk2-derived SATA clock.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  arch/arm/mach-davinci/da850.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>>> index 1d873d1..dbf1daa 100644
>>> --- a/arch/arm/mach-davinci/da850.c
>>> +++ b/arch/arm/mach-davinci/da850.c
>>> @@ -571,7 +571,7 @@ static struct clk_lookup da850_clks[] = {
>>>      CLK("spi_davinci.0",    NULL,           &spi0_clk),
>>>      CLK("spi_davinci.1",    NULL,           &spi1_clk),
>>>      CLK("vpif",             NULL,           &vpif_clk),
>>> -    CLK("ahci_da850",               NULL,           &sata_clk),
>>> +    CLK("ahci_da850",       "sata",         &sata_clk),
>>
>> I'm worry a bit - wouldn't this cause future problems with PM runtime
>>  (if it will be the case)?
>>
>> If this is functional clock - shouldn't it be "fck" to
>> follow PM domain con_id list for davinci?  (arch/arm/mach-davinci/pm_domain.c)
>
> I agree with Grygorii. Calling this clock "fck" will make it easy to
> convert the DA850 AHCI driver to use pm_runtime at a future date (no
> mach-davinci changes should be needed).
>
> Sorry about not spotting this earlier.
>

Hi Sekhar,

I'll wait with sending v7 until we get an ack from Rob for the
ahci-da850 bindings, so that we don't fall to the bottom of the review
queue again.

Thanks,
Bartosz
