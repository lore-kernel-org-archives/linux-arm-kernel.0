From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Wed, 30 Nov 2011 20:09:18 +0530
Subject: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
In-Reply-To: <87y5uz6juz.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
 <87obwsg9ua.fsf@ti.com>
 <CAC83ZvKd3iBrQS5wESnAok8W_a4z-3jZYz17wy376sZJw6sCWg@mail.gmail.com>
 <CAC83Zv++T96AZRHbEiS_UaGp=Dmu+zQ8se97oaBLhg_+eW-smA@mail.gmail.com>
 <87y5uz6juz.fsf@ti.com>
Message-ID: <CANrkHUYb1kM03yfp4ak=5biAMJGuXpkRMhg0TU2H6_0GAiZTTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 8:45 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> On Fri, Nov 4, 2011 at 2:57 PM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>>> On Fri, Nov 4, 2011 at 3:14 AM, Kevin Hilman <khilman@ti.com> wrote:
>>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>>
>>>>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>>>>
>>>> Using this series on 3630/Zoom3, UART wakeups no longer work from
>>>> suspend. ?That suggests that GPIO wakeups from retention/off are not
>>>> working.
>>>>
>>>> Please test GPIO wakeups from retention/off. ?One way is to use Zoom3
>>>> UART wakeup from suspend using by enabling UART wakeups and suspending:
>>>>
>>>> ? # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
>>>> ? # echo mem > /sys/power/state
>>> Ok, I will test and make necessary fix.
>> I have done retention test of the latest series on Zoom3. When I try
>> running off mode
>> test it says support is not present because of an errata.
>
> Specifically, CORE off is not supported on that rev of 36xx due to an
> errata. ?Can you try on a newer 36xx?
>
>> Here is the overall log:
>
> The rest of the dump seems to point to an MMC driver problem. ?Please
> take this with the MMC driver folks.
Hi Tarun,

Can you try with this patch queued in mmc-next for MMC warning
http://article.gmane.org/gmane.linux.kernel.mmc/10961
