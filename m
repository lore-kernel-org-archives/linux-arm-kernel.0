From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 25 Jan 2016 21:07:12 +0600
Subject: [PATCH 2/3] ACPI: parse SPCR and enable matching console
In-Reply-To: <CAHp75VeosA-54-G1oSo3cBo2KRO+rK=Q4DJxmz93WxUPORqf1Q@mail.gmail.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-3-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75VeosA-54-G1oSo3cBo2KRO+rK=Q4DJxmz93WxUPORqf1Q@mail.gmail.com>
Message-ID: <56A63A20.4040602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25.01.2016 20:14, Andy Shevchenko wrote:
> On Mon, Jan 25, 2016 at 1:45 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> 'ARM Server Base Boot Requiremets' [1] mention SPCR
>> (Serial Port Console Redirection Table) [2] as a mandatory ACPI table
>> that specifies the configuration of serial console.
>>
>> Parse this table and check if any registered console match
>> the description.  If it does, enable that console.
>>
>> To implement that, introduce a new member
>> int (*acpi_match)(struct console *, struct acpi_table_spcr *)
>> of struct console.  It allows drivers to check if they provide
>> a matching console device.
>>
>> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
>> [2] http://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
>
> Can you split this to several patches?

I am not sure I should.

> I see preparatory patch in console code, i.e.
> delete_from_console_list(), adding SPCR support to ACPI, enabling it.

It would be difficult to justify delete_from_console_list() in a 
separate patches before the rest of the changes. And enabling SPCR in a 
separate patch also looks oddly for me.

It would be great to have other comments on this before I fix this in 
the next version.

Thank you
