From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Tue, 22 Apr 2014 15:01:48 +0200
Subject: [PATCH v2] arm64: enable EDAC on arm64
In-Reply-To: <CAL_Jsq+N4WgCN3DAigaPW_D=hujL+JQMxaM5rXz0TcQ1VWX8AA@mail.gmail.com>
References: <1385154308-31335-1-git-send-email-robherring2@gmail.com>	<loom.20140410T150903-818@post.gmane.org>	<534C5F69.8030208@codeaurora.org>
 <CAL_Jsq+N4WgCN3DAigaPW_D=hujL+JQMxaM5rXz0TcQ1VWX8AA@mail.gmail.com>
Message-ID: <5356683C.7090909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for taking care of that. Please see question below.

On 21.04.2014 18:19, Rob Herring wrote:
> On Mon, Apr 14, 2014 at 5:21 PM, Rohit Vaswani <rvaswani@codeaurora.org> wrote:
>> On 4/10/2014 6:10 AM, Tomasz Nowicki wrote:
>>>
>>> Rob Herring <robherring2 <at> gmail.com> writes:
>>>
>>>> From: Rob Herring <rob.herring <at> calxeda.com>
>>>>
>>>> Implement atomic_scrub and enable EDAC for arm64.
>>>>
>>>> Signed-off-by: Rob Herring <rob.herring <at> calxeda.com>
>>>> Cc: Catalin Marinas <catalin.marinas <at> arm.com>
>>>> Cc: Will Deacon <will.deacon <at> arm.com>
>>>> ---
>>>> v2:
>>>> - Add loop for exclusive store success
>>>> - Fix size to be 32-bits at a time. The framework gives no alignment
>>>>     guarantees.
>>>>
>>> Hi Rob,
>>>
>>> I am working on memory error for ARM64 and wondering what is your plans
>>> regarding this patch. It looks essential for my further work.
>>>
>>> Regards,
>>> Tomasz
>>>
>> Hi Tomasz, Rob,
>>
>> I am looking at similar information for A53 and A57 for the L1/L2 single and
>> double bit ecc errors.
>> Is there an upstream/linaro effort for EDAC driver in progress ?
>
> I just sent out v3.
>
> There is work to develop a generic RAS framework based on perf which
> would hopefully replace EDAC and mcelog(x86 only).

What do you mean by EDAC and mcelog replacement with RAS framework?

> Jean Pihet has
> picked up this work recently. There probably needs to be some
> infrastructure work to handle SError events as I believe that is how
> cache ECC errors are reported. Although those may get handled by
> firmware and then passed to the OS via some other mechanism like ACPI.


Tomasz
