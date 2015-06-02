From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 2 Jun 2015 10:27:45 -0700
Subject: [PATCH v2 4/6] gpio: brcmstb: Allow GPIOs to be wakeup sources
In-Reply-To: <CACRpkdYnZ9nYHPoUsmgLUtKhB2Us0c_scAYsZVJJQK2orKcpVA@mail.gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-5-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkdYnZ9nYHPoUsmgLUtKhB2Us0c_scAYsZVJJQK2orKcpVA@mail.gmail.com>
Message-ID: <CADtm3G6N-DAYivc_33ReEpu0foi8yt1YdtLGttj9LBjUOmP5RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 6:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, May 29, 2015 at 4:14 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
>
>> Several drivers (e.g. gpio-keys) allow for GPIOs to be configured as
>> wakeup sources, and this GPIO controller supports that through a
>> separate interrupt path.
>>
>> The de-facto standard DT property "wakeup-source" is checked, since
>> that indicates whether the GPIO controller hardware can wake.  Uses
>> the IRQCHIP_MASK_ON_SUSPEND irq_chip flag because UPG GIO doesn't have
>> any of its own wakeup source configuration.
>>
>> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
>
> (...)
>> +       if (enable)
>> +               enable_irq_wake(priv->parent_wake_irq);
>> +       else
>> +               disable_irq_wake(priv->parent_wake_irq);
>> +       return 0;
>
> No error handling? If the code assumes these calls will
> always succeed, atleast write that in a comment.

Will add error handling.

Thanks,
Gregory
