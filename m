From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 5 Jun 2014 20:51:54 -0700
Subject: [PATCH-next] mfd: ab8500: fix dt irq mapping
In-Reply-To: <CACRpkda7EEJNmfjHseQP9ChQ+OJf62qe=aBy3FJ-EFPGO1r6cg@mail.gmail.com>
References: <1401726478-14879-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkda7EEJNmfjHseQP9ChQ+OJf62qe=aBy3FJ-EFPGO1r6cg@mail.gmail.com>
Message-ID: <CAGa+x85hBhwff_2gp8Wf+MGHUypC_qaa5AgeQMfjVffCZnbrRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 3, 2014 at 4:21 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 2, 2014 at 6:27 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>
>> The AD8500 defines itself as interrupt-controller in DT,
>> but it doesn't assign DT node to IRQ domain when creates it.
>> As result, of_irq_xx() helpers don't work because they can't
>> find necessary IRQ domain.
>>
>> Hence, fix it by assigning AD8500 core device DT node to IRQ
>> domain when it's created.
>>
>> This patch fixes STE u8500 Snowball boot failure reported by Kevin Hilman
>> https://lkml.org/lkml/2014/5/27/624
>>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Reported-and-tested-by: Kevin Hilman <khilman@linaro.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Anyone picking this one up?  It's still broken in -next, and will be
needed for v3.16.

Kevin
