From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 1 Apr 2016 15:34:50 +0200
Subject: [PATCH] kallsyms: ignore ARM mode switching veneers
In-Reply-To: <2625557.ANpx9Yzf9D@wuerfel>
References: <1456516254-15615-1-git-send-email-ard.biesheuvel@linaro.org>
 <2625557.ANpx9Yzf9D@wuerfel>
Message-ID: <CAKv+Gu-4SzHjEraV48X=USRRkU6XCO8BK+7bMz78q7J_BbZb7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2016 at 21:21, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 February 2016 20:50:54 Ard Biesheuvel wrote:
>> On ARM, the linker may emit veneers to deal with relative branch
>> instructions that appear too far away from their targets. Since the second
>> kallsyms pass results in an increase of the kernel size, it may result in
>> additional veneers to be emitted, potentially affecting the output of
>> kallsyms itself if these symbols are visible to it, and for that reason,
>> symbols whose names end in '_veneer' are ignored explicitly.
>>
>> However, when building Thumb2 kernels, such veneers are named differently
>> if they also incur a mode switch, and since they are not filtered by
>> kallsyms, they may cause the build to fail. So filter symbols whose names
>> end in '_from_arm' or '_from_thumb' as well.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
>
> Thanks again for debugging this!
>
> I have two (randconfig) configurations that ran into this problem, and they
> are both with your patch
>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
>

Added to the patch tracker as #8555
