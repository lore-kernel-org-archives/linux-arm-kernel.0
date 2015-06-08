From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 8 Jun 2015 09:00:38 +0200
Subject: [RESEND 1/2] usb: ehci-exynos: Make provision for vdd regulators
In-Reply-To: <CAJKOXPc+XKnZbDcdPgyGeaRD+wU2ef0AqiGwWjhJfCbX27c06A@mail.gmail.com>
References: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
 <5574F97A.5030104@samsung.com>
 <CANAwSgTjx8uxyOTW8uuiqrcNzF+UwLMmML2OcDgG5Ku_56=vJQ@mail.gmail.com>
 <CAJKOXPfDmt5VMqr-P+OpWy1+jz675CFRPmtS_N0HjN4tWxfwtA@mail.gmail.com>
 <CABxcv=kMi1dveFOWq6JVEAGTtZLCVHcCcWLyLZzJLaYTx0M3fw@mail.gmail.com>
 <CAJKOXPc+XKnZbDcdPgyGeaRD+wU2ef0AqiGwWjhJfCbX27c06A@mail.gmail.com>
Message-ID: <CABxcv==89MBuB9f7Zf_jO_wa4nr6ADYqfx8N+A4SeZJ-ccmBEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On Mon, Jun 8, 2015 at 8:52 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-06-08 15:42 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
>> Hello,
>>
>> On Mon, Jun 8, 2015 at 7:14 AM, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>
>> [...]
>>
>>>
>>> To summarize my point of view:
>>> 1. Unless Vivek's says otherwise, please give him the credits with
>>> proper "from" field.
>>> 2. Issues mentioned in previous mail should be addressed (missing
>>> IS_ERR(), how disabling the regulator during suspend affects waking
>>> up).
>>> 3. The patchset must be tested, even after rebasing.
>>>
>>
>> Agreed with all the points.
>>
>> Anand,
>>
>> An easy way to preserve authorship when rebasing patches is to use the
>> git command author option. As an example you can execute the following
>> command:
>>
>> $ git commit -a -s --author='Vivek Gautam <gautam.vivek@samsung.com>'
>
> By default "git am" and "git format-patch" preserve the author of a
> patch so usually this step is not necessary. Unless the patch is
> applied in a different way... :)
>

That is correct but if an old patch still applies cleanly on top of
current's tree, then there is no need to do a rebase right? ;-)

I mean, git am is not as smart as the patch command for example to
detect when the line numbers mentioned in the patch are incorrect and
does not attempt to find the correct place to apply each hunk of the
patch (at least by default, I don't know if there is an option).

Which IIUC is what Anand had to do so in that case you need to
manually commit again but using the original patch author.

> Best regards,
> Krzysztof

Best regards,
Javier
