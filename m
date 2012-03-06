From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Tue, 6 Mar 2012 14:40:57 +0530
Subject: [PATCH] omap3_beagle: Init only uart3 used for console
In-Reply-To: <87399mkecv.fsf@ti.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
 <87399mkecv.fsf@ti.com>
Message-ID: <CAMrsUdLWaLqSr-PCmmGxrp0qZSojr5EWAUYmuk6v2pHiVdf9kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 1:30 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> On beagle some of uart mux lines are used for other
>> purpose so init only uart3.
>
> OK, but you should also be clear that this patch is effectively
> disabling all UARTS (except UART3) by defatul, which I'm not sure all
> Beagle users will be happy about.
>

Okay, I have posted new version of the patch
"[PATCH] omap3_beagle: init uart2 for beagle rev AX/BX only"

which initialises uart1/3/4 on all beagle boards

and uart2 init is done for only beagle rev ax/bx
which doesn't seem to have external usb module.


>> Uart2 rx line clashes with gpio_147 used for usb ehci
>> phy reset. Initializing uart2 pad_mux lines can break
>> ehci module on beagle xm.
>> (gpio_147 is available on uart2_rx in mode4 reference
>> mux34xx.c -> uart2_rx.gpio_147)
>
> As Koen mentioned, this conflict only exists on certain boards, so
> you should be clear that this is just an example.
>

conflict exists all beagle rev's expect rev ax/bx.

--
Thanks,
Govindraj.R
