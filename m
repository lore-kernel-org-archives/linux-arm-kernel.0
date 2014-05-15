From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 15 May 2014 09:15:06 +0200
Subject: [PATCH] i2c: nomadik: Fixup system suspend
In-Reply-To: <CAPDyKFo6K-mbtKcs8wPmc=E-t=Djs-ufi_+SLLpCKej+bEwbDw@mail.gmail.com>
References: <1397138376-28427-1-git-send-email-ulf.hansson@linaro.org>
 <CACRpkdb8VJ_Qqype4uP_YJ5=RncJndFUZv_yDxmZwq5S=_yZ2g@mail.gmail.com>
 <CAPDyKFo6K-mbtKcs8wPmc=E-t=Djs-ufi_+SLLpCKej+bEwbDw@mail.gmail.com>
Message-ID: <CAPDyKFqxa3ZveRUWseT25cSOcn-6vUVBR0q515qsha1z0WfdNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 May 2014 11:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 10 April 2014 20:49, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Thu, Apr 10, 2014 at 3:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>> For !CONFIG_PM_RUNTIME, the device were never put back into active
>>> state while resuming.
>>>
>>> For CONFIG_PM_RUNTIME, we blindly trusted the device to be inactive
>>> while we were about to handle it at suspend late, which is just too
>>> optimistic.
>>>
>>> Even if the driver uses pm_runtime_put_sync() after each tranfer to
>>> return it's runtime PM resources, there are no guarantees this will
>>> actually mean the device will inactivated. The reason is that the PM
>>> core will prevent runtime suspend during system suspend, and thus when
>>> a transfer occurs during the early phases of system suspend the device
>>> will be kept active after the transfer.
>>>
>>> To handle both issues above, use pm_runtime_force_suspend|resume() from
>>> the system suspend|resume callbacks.
>>>
>>> Cc: Alessandro Rubini <rubini@unipv.it>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Hi Wolfram,
>
> This patch as has been around for a while (in some other versions as
> well), would you mind picking it up for 3.16?
>

Ping.

I noticed you merged my other i2c-nomadik patch yesterday - thought I
might remind you about this one as well.

Kind regards
Ulf Hansson
