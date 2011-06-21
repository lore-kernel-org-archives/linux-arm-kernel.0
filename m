From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 21 Jun 2011 18:25:43 +0800
Subject: [PATCH 2/2] ARM: pxa168: correct nand pmu setting
In-Reply-To: <BANLkTikRHpDzsfBMvO+9bXzaOn+i7vC1VA@mail.gmail.com>
References: <1308650059-27226-1-git-send-email-leiwen@marvell.com>
	<1308650059-27226-2-git-send-email-leiwen@marvell.com>
	<BANLkTimKsHSODub79sc9MbNqVbtFqYzHDw@mail.gmail.com>
	<BANLkTinLq82kj5JdWDFA93=86sUjVZJR2A@mail.gmail.com>
	<BANLkTik-JU2_N3yNU-PMhk2dXStnvNPG=w@mail.gmail.com>
	<BANLkTikRHpDzsfBMvO+9bXzaOn+i7vC1VA@mail.gmail.com>
Message-ID: <BANLkTikcuu7SaWLH2h0xPWfpr-D6F0hyWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 6:21 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
> On Tue, Jun 21, 2011 at 6:17 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Tue, Jun 21, 2011 at 6:14 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
>>> Hi Eric,
>>>
>>> On Tue, Jun 21, 2011 at 6:09 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>> On Tue, Jun 21, 2011 at 5:54 PM, Lei Wen <leiwen@marvell.com> wrote:
>>>>> The original pair of <0x01db, 208000000> is invalid.
>>>>> Correct to the valid value.
>>>>>
>>>>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>>>>
>>>> Lei,
>>>>
>>>> As pxa168 boards are available outside now, please describe more on this
>>>> change. Due to silicon revision, erratum, or due to the original code was
>>>> too long ago that it is no long valid.
>>>>
>>>> Note - check the pxa168 boards file, make sure the change will not affect
>>>> them.
>>>
>>> That value 0x01db only means 78Mhz, and from all doc I could refer to
>>> the 0x01db never reach
>>> to 208MHZ...
>>>
>>> Do you means I should keep the 0x1db register value?
>>
>> I didn't mean that. I just want to make it clear why the original code was
>> wrong. So my understanding:
>>
>> 1. 0x01db was wrong - it doesn't make a clock rate of 208MHz
> 0x1db is valid value, and yes it doesn't make a clock rate to 208Mhz,
> but only to 78Mhz
>
>> 2. 208MHz was also wrong - the default should be 156MHz?
> 208Mhz is totally wrong, the NFC never reach this on pxa168.
>
> So the 0x1db<->78Mhz, and 0x19b<->156Mhz.
>

OK, that makes a lot sense. Could you update the patch with the
above description in the commit message? Thanks.

> Best regards,
> Lei
>
