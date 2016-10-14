From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 14 Oct 2016 19:23:15 +0100
Subject: [PATCH] arm64: kaslr: fix breakage with CONFIG_MODVERSIONS=y
In-Reply-To: <57FFE78E.4040002@codeaurora.org>
References: <1476376929-29688-1-git-send-email-ard.biesheuvel@linaro.org>
 <57FFE78E.4040002@codeaurora.org>
Message-ID: <CAKv+Gu-sdgkoQvbpgHXZmDyxg6NTGJpC+hsqzdbwTkny+TeqfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2016 at 20:59, Timur Tabi <timur@codeaurora.org> wrote:
> Ard Biesheuvel wrote:
>>
>> As it turns out, the KASLR code breaks CONFIG_MODVERSIONS, since the
>> kcrctab has an absolute address field that is relocated at runtime
>> when the kernel offset is randomized.
>>
>> This has been fixed already for PowerPC in the past, so simply wire up
>> the existing code dealing with this issue.
>>
>> Signed-off-by: Ard Biesheuvel<ard.biesheuvel@linaro.org>
>
>
> Tested-by: Timur Tabi <timur@codeaurora.org>
>

Thanks. I will resend this with a fixes: tag and a better description
