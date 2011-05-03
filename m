From: khilman@ti.com (Kevin Hilman)
Date: Tue, 03 May 2011 09:35:46 -0700
Subject: [PATCH 13/15] OMAP: GPIO: cleanup _set_gpio_wakeup(),
	remove ifdefs
In-Reply-To: <BANLkTi=z3zk2E5Big5Ot-QXP86gBr=D53w@mail.gmail.com> (Charulatha
	Varadarajan's message of "Tue, 26 Apr 2011 20:14:05 +0530")
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-14-git-send-email-khilman@ti.com>
	<BANLkTi=z3zk2E5Big5Ot-QXP86gBr=D53w@mail.gmail.com>
Message-ID: <87aaf3g2sd.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
>> Make _set_gpio_wakeup() generic by removing ifdefs. ?Code for the
>> various SoCs/bank-methods was already the same, except for the
>> non-wakeup GPIO checking. ?But that flag is set on a per-SoC basis, so
>> can be used for all SoCs.
>>
>> While here, use pr_err() and remove GPIO bank calculation assumption
>> based on subtracting bank pointers.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>

[...]

>> -#endif
>> - ? ? ? default:
>> - ? ? ? ? ? ? ? printk(KERN_ERR "Can't enable GPIO wakeup for method %i\n",
>> - ? ? ? ? ? ? ? ? ? ? ?bank->method);
>> + ? ? ? if (bank->non_wakeup_gpios & gpio_bit) {
>> + ? ? ? ? ? ? ? pr_err("Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
>
> use dev_err instead.

Agreed, thanks.

Kevin
