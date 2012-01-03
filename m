From: sjg@chromium.org (Simon Glass)
Date: Tue, 3 Jan 2012 11:50:13 -0800
Subject: [PATCH] ARM: Remove BUILD_BUG_ON from asm/bug.h
In-Reply-To: <CAOesGMiN_yOxDT1Xrn3LOU+D027+oC3fxTPkph-WzpVPE-86Mg@mail.gmail.com>
References: <1325616276-10304-1-git-send-email-sjg@chromium.org>
 <CAOesGMiN_yOxDT1Xrn3LOU+D027+oC3fxTPkph-WzpVPE-86Mg@mail.gmail.com>
Message-ID: <CAPnjgZ31hQS35Zq6Mb+cc770vabgtwNYqJoEySbbG-JKGahPnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jan 3, 2012 at 11:39 AM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Jan 3, 2012 at 10:44 AM, Simon Glass <sjg@chromium.org> wrote:
>> BUILD_BUG_ON is defined in linux/kernel.h but that is not included by the
>> asm/bug.h header which uses it. This causes a build error:
>>
>> ...include/linux/mtd/map.h: In function 'inline_map_read':
>> ...include/linux/mtd/map.h:408:3: error: implicit declaration of function
>> 'BUILD_BUG_ON' [-Werror=implicit-function-declaration]
>>
>> The check is not essential and is not present for other architectures, so
>> just remove it.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> Simon, have you sent it to Russell's patch tracker? If not, please do.

Done

Regards,
Simon

>
>
> -Olof
