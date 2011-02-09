From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 9 Feb 2011 10:40:07 +0100
Subject: [PATCH 2/2] ARM: iMX5 BBG: add cpuidle driver parameters
In-Reply-To: <4D518263.2070503@gmail.com>
References: <1297178084-28363-1-git-send-email-yong.shen@linaro.org>
	<1297178084-28363-3-git-send-email-yong.shen@linaro.org>
	<87pqr2v91r.fsf@lechat.rtp-net.org>
	<AANLkTiko-OjXp2SER0=fh0acSXwYDEav=kQE94UB4zY9@mail.gmail.com>
	<4D518263.2070503@gmail.com>
Message-ID: <AANLkTi=z4TmcOS1JCiMfYY546jz-MrUJMPKzw+Pz9Qru@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 8, 2011 at 6:50 PM, Rob Herring <robherring2@gmail.com> wrote:

> On 02/08/2011 09:51 AM, Yong Shen wrote:
>
>> Hi Arnaud,
>>
>> I also took a while to think about this before posting patches. I prefer
>> to put it in board related code since the various PMIC used on each
>> boards may have influence on cpuidle latency or other charactors,
>> although it could be minor.
>>
>>
> But you are not going to be doing voltage scaling in idle. Is it even
> possible to do sleeping operations like accessing a PMIC in idle?
>
I guess you are asking if modes like 'state retention' are possible for idle
state. so far there is no official mapping between c-states and various arm
idle states, which is something linaro power management group is working on.
Therefore I also treat 'state retention' as a c-state.

ps. remove lpdk in cc list to avoid auto-reply messages.
Yong

>
> The core is powergated, so lowering voltage would not help. Doing bus
> scaling or DDR self-refresh are the only likely additional operations.
>
> Rob
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110209/fe299280/attachment-0001.html>
