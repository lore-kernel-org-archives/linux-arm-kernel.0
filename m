From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 08 Jun 2015 22:21:46 +0900
Subject: [RESEND 1/2] usb: ehci-exynos: Make provision for vdd regulators
In-Reply-To: <CANAwSgTi114wO63-sx=UmbxPerqKvstq=coVyqhRkzX44CDe_w@mail.gmail.com>
References: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
 <5574F97A.5030104@samsung.com>
 <CANAwSgTjx8uxyOTW8uuiqrcNzF+UwLMmML2OcDgG5Ku_56=vJQ@mail.gmail.com>
 <CAJKOXPfDmt5VMqr-P+OpWy1+jz675CFRPmtS_N0HjN4tWxfwtA@mail.gmail.com>
 <44B5E2FDCD3244AAA418BB8EC28FEA25@sisodomain.com>
 <CANAwSgTi114wO63-sx=UmbxPerqKvstq=coVyqhRkzX44CDe_w@mail.gmail.com>
Message-ID: <557596EA.50103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 08.06.2015 o 19:20, Anand Moon pisze:
> On 8 June 2015 at 10:58, Vivek Gautam <gautam.vivek@samsung.com> wrote:
>> Hi,
>>

(...)

>>
>> On Monday, June 08, 2015 10:44 AM, "Krzysztof Kozlowski"
>> <k.kozlowski@samsung.com> wrote:
>>
>>> Untested code should not go to the kernel. Additionally you should
>>> mark it as not-tested. Marking such patch as non-tested could help you
>>> finding some independent tests (tests performed by someone else).
>>>
>>> To summarize my point of view:
>>> 1. Unless Vivek's says otherwise, please give him the credits with
>>> proper "from" field.
>>> 2. Issues mentioned in previous mail should be addressed (missing
>>> IS_ERR(), how disabling the regulator during suspend affects waking
>>> up).
>>> 3. The patchset must be tested, even after rebasing.
>>
>>
>> Unfortunately, I got busy  with a different project and lost track of the
>> patches posted upstream.
>> If it's not too late I can post a rebased version of the patch with previous
>> review comments addressed.
>>
>>>
>>> Best regards,
>>> Krzysztof
>>
>>
> 
> Hi All,
> 
> I have learned my lesson not to interfere in others work.
> It will never happen from my side again.
> 
> Please accept my apology.

Sure, no problem. Mistakes happen (I make a lot of them too), just learn
from them.

Javier explained what was the proper way to do this - retain original
author of the patch. Your signed-off-by was correct.

In fact the kernel SubmittingPatches is worth reading from time to time:
https://www.kernel.org/doc/Documentation/SubmittingPatches
Under chapter 11th ("Sign your work") in paragraph starting with "If you
are a subsystem or branch maintainer" - it explains how to mention
changes when modifying someone's else patch.

You can also look at example from Bartlomiej, how hge did this when he
took Thomas' patches:
https://lkml.org/lkml/2015/4/3/387
However his case is kind of special because he made such a lot of
changes and made such huge effort that in my humble opinion he could
take the authorship of patch. But in this case the changelog is huge.
And he tested it. Extensively. However he did not change the author of
patches :) and you can just look at this work as an example.

Best regards,
Krzysztof
