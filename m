From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 11:39:52 +0300
Subject: [PATCH V3 1/4] Input: pxa27x_keypad keep clock on as wakeup source
In-Reply-To: <CAN1soZxTfp9p-JoTmXRDFYLKt0mmgcSwc5F9Tk8b+E0fQRW6AQ@mail.gmail.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
 <CAN1soZyBPE3YExELmu5yHeMTWQf9Zs07v26F6Qz3ocKO+cXGFw@mail.gmail.com>
 <CAN1soZxTfp9p-JoTmXRDFYLKt0mmgcSwc5F9Tk8b+E0fQRW6AQ@mail.gmail.com>
Message-ID: <CA+E=qVd4tFhkh3PJe4-4Y-cCm6eO==vd8nU-rxa6K-1ObDYMJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 12:04 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Mon, Apr 2, 2012 at 5:37 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
>>> When the keypad is used as wake up source, the clock can not
>>> be disabled. Or it can not detect key pressing.
>>> If the keypad is used as wake up source, when resume back,
>>> do not enable the clock and configure it again because the
>>> register content is retained.
>>>
>>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>>> ---
>>
>> Hi Dmitry,
>>
>> I just found that you're not looped in this mail thread. Could I merge
>> them into arch-pxa tree?
>>
>> Best Regards
>> Haojian
>
> Applied
>
> Regards
> Haojian

Hi,

This patch breaks pxa27x_keypad on pxa270-based Zipit Z2 device. After
resume keypad is not working anymore.
Reverting this patch fixes issue. Looks like it's necessary to call
pxa27x_keypad_config() on resume (at least on pxa27x?)

Regards
Vasily
