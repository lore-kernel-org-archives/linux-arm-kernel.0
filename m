From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 16 Jun 2016 19:28:59 +0200
Subject: [PATCH 2/2] arm64: drop kernel segment resources from /proc/iomem
In-Reply-To: <CAGXu5jLWs0FiN1wri51WFSS__8kfLMMeYtUTspuHqi4pmFHEAA@mail.gmail.com>
References: <1466080138-12193-1-git-send-email-ard.biesheuvel@linaro.org>
 <1466080138-12193-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu8ZO3Pz8vq9mM-XSDa1-L877-mzD1pBhhhJw0Z5jXCk0Q@mail.gmail.com>
 <CAGXu5jLWs0FiN1wri51WFSS__8kfLMMeYtUTspuHqi4pmFHEAA@mail.gmail.com>
Message-ID: <CAKv+Gu84hr4d--cRUZzpGnA7NXr3pxE-VdRsaTGjUYX9aiet4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 June 2016 at 19:21, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jun 16, 2016 at 5:32 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> (+ James)
>>
>> On 16 June 2016 at 14:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> By the same reasoning as commit c4004b02f8e5 ("x86: remove the kernel
>>> code/data/bss resources from /proc/iomem"), the kernel code and kernel
>>> data entries in /proc/iomem probably do more harm than good on arm64 as
>>> well. So remove them.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>>
>> Actually, Linus's patch above has been reverted again, so we have to
>> consider whether the kexec case exists for us as well before we
>> consider this
>>
>> Apologies for failing to spot that before sending
>
> Please leave this as it was originally. The security exposure has been
> minimized and it would make arm64 differ from all other architectures.
> If we remove this, it needs to be coordinated across all
> architectures.
>

OK, fair enough
