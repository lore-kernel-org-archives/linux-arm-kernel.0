From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 29 Aug 2014 08:35:16 +0800
Subject: [RESEND PATCH] ARM: dts: make arch-timer always on in rk3288 soc
In-Reply-To: <20140828151121.GM14650@leverpostej>
References: <1409190017-12656-1-git-send-email-kever.yang@rock-chips.com>
 <20140828091758.GB14650@leverpostej> <20140828151121.GM14650@leverpostej>
Message-ID: <53FFCAC4.7030702@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

     Thanks for your reply and advice.

On 08/28/2014 11:11 PM, Mark Rutland wrote:
> On Thu, Aug 28, 2014 at 10:17:58AM +0100, Mark Rutland wrote:
>> Hi Kever,
>>
>> On Thu, Aug 28, 2014 at 02:40:17AM +0100, Kever Yang wrote:
>>> We need use the hrtimer, which need the arch-timer to be 'always-on'
>> I asked a question on the last posting [1]. Can you please confirm
>> either way?
>>
>> Thanks,
>> Mark.
>>
>> [1] lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282327.html
> To clarify: if there are low power states that the CPU can enter where
> we lose state, then this patch isn't correct.
rk3288 has low power state and may turn off the cpu power domain
which will lost any logic state in cpu.
>
> A more general approach would be to enable the broadcast hrtimer for
> arm, as has been done for arm64.
>
> See commit 5d1638acb9f6 (tick: Introduce hrtimer based broadcast) which
> introduced the broadcast hrtimer, and commit 9358d755bd5c (arm64:
> kernel: initialize broadcast hrtimer based clock event device) which
> added the requisite plumbing for arm64.
I'll going to implement this and send another patch.

Thanks.

-Kever
