From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Jul 2016 14:42:00 +0800
Subject: [PATCH] clocksource: sun4i: Clear interrupts after stopping timer
 in probe function
In-Reply-To: <20160726054937.GS7419@lukather>
References: <1469502119-2344-1-git-send-email-wens@csie.org>
 <20160726054937.GS7419@lukather>
Message-ID: <CAGb2v65qoKXO8oQZBMumGZ_VM7KR_236wSNJZMd+VdSGTQu_xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 1:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jul 26, 2016 at 11:01:59AM +0800, Chen-Yu Tsai wrote:
>> The bootloader (U-boot) sometimes uses this timer for various delays.
>> It uses it as a ongoing counter, and does comparisons on the current
>> counter value. The timer counter is never stopped.
>>
>> In some cases when the user interacts with the bootloader, or lets
>> it idle for some time before loading Linux, the timer may expire,
>> and an interrupt will be pending. This results in an unexpected
>> interrupt when the timer interrupt is enabled by the kernel, at
>> which point the event_handler isn't set yet. This results in a NULL
>> pointer dereference exception, panic, and no way to reboot.
>>
>> Clear any pending interrupts after we stop the timer in the probe
>> function to avoid this.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Awesome, thanks!
>
> You should put stable in Cc though for this kind of patches.

AFAIK some maintainers prefer to add it themselves. Not sure about
clocksource so I left it out.

ChenYu
