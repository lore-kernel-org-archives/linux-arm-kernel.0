From: robh@kernel.org (Rob Herring)
Date: Mon, 18 May 2015 08:18:00 -0500
Subject: [PATCH v4 0/6] SA1100/PXA RTC clean-up
In-Reply-To: <87pp62jdpj.fsf@belgarion.home>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home>
Message-ID: <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 6:13 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
>> testing on PXA27x/3xx.
> Hi Rob,
>
> I tested on PXA27x. It works for the boards which used pxa-rtc.
> For the others, their defconfig become broken, because the pxa boards with
> sa1100-rtc do not work anymore. And of course no .config manipulation will fix
> this, because PXA architecture is denied the sa1100-rtc driver.

Ah, I didn't realize there is a mixture of use.

I could just do something like this instead of removing
sa1100_device_rtc registration:

#ifndef CONFIG_RTC_DRV_PXA
       &sa1100_device_rtc,
#else
        &pxa_device_rtc,
#endif

Rob
