From: robh@kernel.org (Rob Herring)
Date: Wed, 4 Feb 2015 07:49:25 -0600
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <CAL_JsqL8iahGwkPyDuB+2j_SvkH0TYYNDErgLOgHOgHvERU-9A@mail.gmail.com>
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org>
 <39285522.vUKlahhjIR@wuerfel>
 <CAL_JsqL8iahGwkPyDuB+2j_SvkH0TYYNDErgLOgHOgHvERU-9A@mail.gmail.com>
Message-ID: <CAL_JsqLSHrbQq2qFSpZyoiZ757xs8MHjNFD8+PKBGBTPmEatwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 7:44 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Feb 4, 2015 at 7:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 03 February 2015 17:22:53 Rob Herring wrote:
>>> SA1100 and PXA differ only in register offsets which are currently
>>> hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
>>> have this RTC block also.
>>>
>>> Convert the driver to use ioremap and set the register offsets dynamically.
>>> Since we are touching all the register accesses, convert them all to
>>> readl/writel.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>>> Cc: rtc-linux at googlegroups.com
>>
>> Hmm, I really should have sent out my version of the patch ages ago. :(
>
> Got any others? :)
>
>>
>> Can you have a look at
>>
>> http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/commit/?h=multiplatform-3.19-next&id=4d9727883a363fb839e7d1633599166c0a08d644
>>
>> to see compare the approaches and see if there is anything I did that you
>> missed?
>
> You used the relaxed variants seems to be the main difference. Yours
> won't build on arm64 either.

Also, I noticed the rtc-puv3 driver appears to be the same programming
model. The quirks around interrupt clearing seem to be a bit different
though.

Rob
