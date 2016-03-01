From: eric@anholt.net (Eric Anholt)
Date: Tue, 01 Mar 2016 10:41:40 -0800
Subject: [PATCH 1/2] clk: bcm2835: expose raw clock-registers via debugfs
In-Reply-To: <56D59998.8060301@martin.sperl.org>
References: <1456755616-2472-1-git-send-email-kernel@martin.sperl.org>
 <1456755616-2472-2-git-send-email-kernel@martin.sperl.org>
 <87k2ln5k09.fsf@eliezer.anholt.net> <56D59998.8060301@martin.sperl.org>
Message-ID: <874mcqrqfv.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

> On 29.02.2016 21:39, Eric Anholt wrote:
>> kernel at martin.sperl.org writes:
>>
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>
>>> For debugging purposes under some circumstance
>>> it helps to be able to see the actual clock registers.
>>>
>>> E.g: when looking at the clock divider it is helpful to
>>> see what the actual clock divider is.
>>>
>>> This patch exposes all the clock registers specific to each
>>> clock/pll/pll-divider via debugfs.
>>>
>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>
>> This one definitely seems useful to me.  I think the debugfs bits need
>> to be under #ifdef CONFIG_DEBUG_FS though.
>>
>> With that fixed,
>>
>> Acked-by: Eric Anholt <eric@anholt.net>
>>
> Note that include/linux/debugfs.h contains such ifdef and generates
> dummy code like this:
> static inline struct dentry *debugfs_create_regset32(const char *name,
>                                     umode_t mode, struct dentry *parent,
>                                     struct debugfs_regset32 *regset)
> {
>          return ERR_PTR(-ENODEV);
> }
> (see also Documentation/filesystem/debugfs.txt )

OK, looks like the CONFIG_DEBUG_FS ifdefs I've seen in other drivers are
just noise.  The patch should be good as-is, then.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160301/cbbb2f9d/attachment.sig>
