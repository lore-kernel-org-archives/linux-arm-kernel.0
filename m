From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 14 Dec 2011 14:51:00 +0530
Subject: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
In-Reply-To: <87zkewt5e0.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
 <87zkewt5e0.fsf@ti.com>
Message-ID: <CAAL8m4w28C3nWO65w=0bwoEvsOT3K9DS67dc5C0e-yuR+rc4Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 5:02 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
> [...]
>
>> I have re-based this patch series against LO master
>> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>>
>> Same is available here [1]
>>
>> I have tested this patch series along with:
>>
>> 1.) Tero's V11 irq chaining series
>> ? ? ?http://www.spinics.net/lists/linux-omap/msg61445.html
>> ? ? (This patch series is used for uart wakeup handling using
>> ? ? ? prcm_irq chaining)
>>
>> 2.) Rajendra's hwmod change
>> ? ? ?http://www.spinics.net/lists/arm-kernel/msg148632.html
>> ? ? ?(This patch handles init_no_idle flag setting
>> ? ? ? without this patch there will be boot warning however
>> ? ? ? all pm features will work after boot up.)
>
> Actually, without Rajendra's patch all features do not work. ?I don't
> get UART console wakeups from idle (with runtime PM autosuspend enabled)
> on 3430/n900 or 3530/Overo without Rajendra's patch.

okay, I forgot last time when I tested without rajendra's patch was
with a custom activate func.
and now we have removed it.
Yes you are correct Rajendra's  patch + Tero's v11 series is a needed
for proper uart_runtime_pm functioning.

--
Thanks,
Govindraj.R
