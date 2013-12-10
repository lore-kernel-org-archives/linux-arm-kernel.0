From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 11:06:22 +0100
Subject: [RFC part2 PATCH 7/9] irqdomain: Add a new API
 irq_create_acpi_mapping()
In-Reply-To: <529F4C90.4070402@linaro.org>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-8-git-send-email-hanjun.guo@linaro.org>
 <CAL_JsqK93mJbFu+GaK_5L14jKnMgctUNdEBqS6K5zKer16Sm3Q@mail.gmail.com>
 <529F4C90.4070402@linaro.org>
Message-ID: <CACRpkdbQo2yTvaaEeXnje41UZYoWudL731KcjjwYXVyip=iifA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 4, 2013 at 4:38 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2013?12?04? 01:25, Rob Herring wrote:
>> On Tue, Dec 3, 2013 at 10:39 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>>
>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>
>>> This patch introduces a new API for acpi based irq mapping.
>>>
>>> [hanjun: Rework this patch to delete the reference to
>>> gic_irq_domain_xlate() which can simplify the code a lot.]
>>>
>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
(...)
>>> +EXPORT_SYMBOL_GPL(irq_create_acpi_mapping);
>>
>> There is nothing ACPI specific about this function. This is simply
>> irq_create_of_mapping w/o translating of_phandle_args to a hwirq and
>> type. So I expect the code to be re-factored here to mirror that.
>
> Sorry for my bad english, do you mean create a OF free function
> and call that from the OF function ?

Sounds like a good idea, like if you move the OF function into
kernel/irq/irqdomain.c and get rid of the OF specific naming
then use that same function from ACPI too. It's all about
using the irq_default_domain in a standard way after all right?

Yours,
Linus Walleij
