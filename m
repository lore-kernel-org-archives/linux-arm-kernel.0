From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 23:10:37 -0800
Subject: [PATCH v2 1/2] Input: tegra-kbc - add device tree bindings
In-Reply-To: <20111228064832.GA29273@core.coreip.homeip.net>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
 <1325053170-6984-2-git-send-email-olof@lixom.net>
 <20111228064832.GA29273@core.coreip.homeip.net>
Message-ID: <CAOesGMg7dC8RRST7z1E3-dFD_Cr3fTwqhEP8V1NnXEiHFZvnGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 27, 2011 at 10:48 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Olof,
>
> On Tue, Dec 27, 2011 at 10:19:29PM -0800, Olof Johansson wrote:
>> This adds a simple device tree binding to the tegra keyboard controller.
>>
>> Also, mark the default keymap as __devinitdata since it is not referenced
>> after boot, and shorten the name to not have to avoid line wraps.
>
> No, let's keep the names prefixed to match the rest of the driver(s).

Sure, if you prefer.

>> +
>> + ? ? pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>
> Error handling is missing. I also dislike devm_* facilities as it causes
> inconsistencies in the way we handle releasing of resources: some of
> them will be released automatically while others need t be released
> manually. I prefer having consistent model.

I disagree -- I think the devm allocators are an excellent invention
instead of open-coding the error handling, which tends to be error
prone and just adds special cases just like you explained below.

But, it's your subsystem and with that being said...

> Does the patch below still work for you?

... sure, if you're happy I'm happy -- it gets the work done, couldn't
ask for more. No need to argue the details further. :)


-Olof
