From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 25 Nov 2010 07:06:47 +0800
Subject: [patch 1/1] iMX51: introduce MX51_GPIO_NR
In-Reply-To: <87zksywt4l.fsf@lechat.rtp-net.org>
References: <20101122224526.987309475@rtp-net.org>
	<AANLkTi=Q=UOSUoJ40ThyyyDqMoC849W-cn36CkVFxKhQ@mail.gmail.com>
	<87zksywt4l.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTimS7o+oyBWQ0aL43t-oRABji5ZNyXGijCSV6ECu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 1:04 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> Fabio Estevam <festevam@gmail.com> writes:
>
> Hi,
>
>> Hi Arnaud,
>>
>> 2010/11/22 Arnaud Patard <arnaud.patard@rtp-net.org>:
>>> Currently, to define a GPIO number, we're using something like :
>>>
>>> #define EFIKAMX_PCBID0 ? ? ? ? (2*32 + 16)
>>>
>>> to define GPIO 3 16.
>>>
>>> This is not really readable and it's error prone imho (note the 3 vs 2).
>>> So, I'm introducing a new macro to define this in a better way. Now, the
>>> code sample become :
>>>
>>> #define EFIKAMX_PCBID0 ? ? ? ? MX51_GPIO_NR(3, 16)
>>
>> Can you rename the macro to MX5x_GPIO_NR instead of MX51_GPIO_NR?
>>
>> This way we can also use this macro for MX53 and MX508 when they show
>> up in mainline.
>
> I've been wondering about to use MX5X instead of MX51 but I kept MX51
> because I didn't know how the GPIO will work on MX53. If they're
> compatible, you're right, the name should be MX5X_GPIO_NR and not
> MX51_GPIO_NR. Assuming you mail means that, I'm going to switch to
> MX5X_GPIO_NR.

For MX5x at lease for now (MX51/53/508), One bank is 32 gpios. But
bank number is different.

Thanks
Richard
