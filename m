From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 28 Apr 2011 22:48:02 +0800
Subject: [PATCH 1/3] i2c: append hardware lock with bus lock
In-Reply-To: <20110428143724.GQ17290@n2100.arm.linux.org.uk>
References: <1303963358-4652-1-git-send-email-haojian.zhuang@gmail.com>
	<20110428102212.2d8d607c@endymion.delvare>
	<BANLkTin6jguQue_0Y74jGPnmhCcvWLBjHg@mail.gmail.com>
	<20110428161625.5eaacb85@endymion.delvare>
	<20110428143724.GQ17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=YeqxF_eu2Q=cy6oAFfyTrzAH6VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 10:37 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 28, 2011 at 04:16:25PM +0200, Jean Delvare wrote:
>> Are you suggesting that the hardware lock wouldn't mind being taken
>> twice by the AP side? If it is the case, then indeed the software mutex
>> is still needed to prevent it from happening.
>>
>> That being said... I guess that avoiding a priority inversion is a good
>> enough reason to always take the rt_mutex, regardless of the hardware
>> lock implementation.
>>
>> So, this patch is
>>
>> Acked-by: Jean Delvare <khali@linux-fr.org>
>>
>> I guess it makes more sense for me to let Ben apply it, as the other
>> two patches in the series are for him too. This will avoid a dependency
>> between our trees.
>
> Only change I'd suggest is passing adapter to the hardware_lock/unlock
> methods. ?Having no arguments what so ever in generic code for this kind
> of stuff looks rather strange and limiting.
>

OK. I'll update it.
