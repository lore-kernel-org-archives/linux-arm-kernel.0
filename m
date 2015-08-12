From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 12 Aug 2015 15:04:22 +0200
Subject: [linux-sunxi] Re: [PATCH resend 1/3] mmc: sunxi: fix timeout in
 sunxi_mmc_oclk_onoff
In-Reply-To: <55CB3ED4.9000201@schinagl.nl>
References: <cover.1439381423.git.hramrach@gmail.com>
 <7f9c6f99b31702c02436ef3356b3ebffa4754260.1439381423.git.hramrach@gmail.com>
 <55CB3CD7.2050200@redhat.com> <55CB3ED4.9000201@schinagl.nl>
Message-ID: <CAOMqctRo8Kp6e33qVqVLNYt9pMmMAuoUHTwmqoBLGSpdQ_vu9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2015 at 14:40, Olliver Schinagl <oliver+list@schinagl.nl> wrote:

>
> On 12-08-15 14:32, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 12-08-15 14:23, michal.suchanek at ruk.cuni.cz wrote:
>>>
>>> The 250ms timeout is too short.
>>>
>>> On my system enabling the oclk takes under 50ms and disabling slightly
>>> over 100ms when idle. Under load disabling the clock can take over
>>> 350ms.
>>>
>>> This does not make mmc clock gating look like good option to have on
>>> sunxi but the system should not crash with mmc clock gating enabled
>>> nonetheless.
>>>
>>> This patch sets the timeout to 750ms and adds debug prints which show
>>> how long enabling/disabling the clock took so more data can be collected
>>> from other systems.
>>>
>>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>
>>
>> This is a big patch for just changing a timeout, most of this is in
>> extra verbosity which IMHO has little value, in the error path w
>> know we will have waited aprox 750 ms, so printing the waiting
>> time there is not worth all the extra code.
>>
>> As for adding the warning I'm even less of a big fan of that,
>> if we need higher timeouts, we need higher timeouts, spamming the
>> kernel logs with that we are actually hitting the higher timeouts
>> is not productive IMHO.
>>
>> Can you please resend this as a one-liner just changing the timeout ?
>>

If we expect the timeout to be short and it isn't that means something is wrong.

The user is probably experiencing degraded performance in that case so
it's good to have a diagnostic for it IMHO.

Yes, printing of the timeout in the error case does not have that much
value but since it's calculated anyway I just pasted it there.

> While I can't speak for Michal obviously,
>
> I left the debugging bit (in my v2 that i sent 2 minutes ago) as both you
> and Hans where content with it back then and both acked it.
>
> Michal, feel free to send the v3 without the debug info, unless you want me
> to do it ;)
>

I don't really care either way so long as the boards do not crash.

Thanks

Michal
