From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Jul 2014 15:11:04 +0800
Subject: [PATCH] pinctrl: sunxi: Fix multi bank interrupt support in
 gpio_to_irq
In-Reply-To: <20140704070355.GI31996@lukather>
References: <1404144299-740-1-git-send-email-wens@csie.org>
 <20140704070355.GI31996@lukather>
Message-ID: <CAGb2v67ZNsq9J1Fs3uURJbDPvCvPUDm6rYXq=FfuZCAo1HtaRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 3:03 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Jul 01, 2014 at 12:04:59AM +0800, Chen-Yu Tsai wrote:
>> When mapping the interrupts, the gpio_to_irq function did not consider
>> the bank number of the gpio pin in question, only the offset or the
>> interrupt number in the bank. As a result, requests for interrupts in
>> the later banks get mapped to the first bank.
>>
>> This issue was discovered while enabling mmc on the new sun8i platform.
>> The tablet I have uses a pin/interrupt from the second bank to do mmc
>> card detection. Tested on this very device with register inspection and
>> actual mmc card insertion/removal.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Linus, could this be merged as a fix for 3.16?

Aren't your multi-bank external interrupt patches queued for 3.17?
This patch applies over them.


ChenYu
