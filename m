From: keescook@chromium.org (Kees Cook)
Date: Tue, 16 Feb 2016 12:35:42 -0800
Subject: [PATCH] arm64: mm: Mark .rodata as RO
In-Reply-To: <56C36EFF.9060900@labbott.name>
References: <1455293599-6974-1-git-send-email-jeremy.linton@arm.com>
 <20160212182527.GG20262@leverpostej>
 <CAGXu5jLpj=ue49_N+LOYvtZcU3rpFR5=WTG15ySDOWprvRzFUA@mail.gmail.com>
 <56C36EFF.9060900@labbott.name>
Message-ID: <CAGXu5j+4uYjTjULw7hzdaYhN+JGqtybEpyT2Cihuj-2gXe=saA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 10:48 AM, Laura Abbott <laura@labbott.name> wrote:
> On 2/16/16 10:10 AM, Kees Cook wrote:
>>
>> On Fri, Feb 12, 2016 at 10:25 AM, Mark Rutland <mark.rutland@arm.com>
>> wrote:
>>>
>>> On Fri, Feb 12, 2016 at 10:13:19AM -0600, Jeremy Linton wrote:
>>>>
>>>> Currently the .rodata section is actually still executable when
>>>> DEBUG_RODATA
>>>> is enabled. This changes that so the .rodata is actually read only, no
>>>> execute.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>
>>
>> Yikes, good catch. Is anyone running the lkdtm tests that check these
>> things?
>>
>
> I don't think the current lkdtm test would have caught this since the exec
> test is using rw data and not ro data. That test could be expanded though
> to include a rodata buffer as well.

Oh, yeah, excellent point. I'll send a patch.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
