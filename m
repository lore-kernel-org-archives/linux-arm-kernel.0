From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 12 Jun 2014 13:14:17 -0400
Subject: [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <4476889.LvjMyVbGZ8@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
 <4476889.LvjMyVbGZ8@wuerfel>
Message-ID: <CAJ5Y-eZ0z-SPSn9oxced2GOAw+OA5rC+uq4pCSXh5H2JujPm1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 June 2014 13:02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 12 June 2014 12:48:10 Ashwin Chaugule wrote:
>>
>> +#ifndef CONFIG_ACPI
>>         if (!mbox->of_xlate)
>>                 mbox->of_xlate = of_mbox_index_xlate;
>> -
>> +#endif
>>         mutex_lock(&con_mutex);
>>         list_add_tail(&mbox->node, &mbox_cons);
>>         mutex_unlock(&con_mutex);
>>
>
> You can't do #ifndef here, the driver must still work if
> both OF and ACPI are enabled.

Ok. Here we could skip the macro altogether, since of_xlate wont be
called with ACPI anyway.

Will need to look into using/faking mbox->dev to remove the other ifndefs.

Cheers,
Ashwin
