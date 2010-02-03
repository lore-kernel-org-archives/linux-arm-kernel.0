From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 3 Feb 2010 01:31:49 -0500
Subject: [PATCH 1/1] mmp2: add handling on PMIC IRQ
In-Reply-To: <f17812d71002021614n4d9838dh1e2ad6e6be2843c5@mail.gmail.com>
References: <771cded01001262208p2da963dbhf51a245606741bfc@mail.gmail.com>
	<f17812d71002021614n4d9838dh1e2ad6e6be2843c5@mail.gmail.com>
Message-ID: <771cded01002022231k5c02110ak75aee6a96d8746ac@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2010 at 7:14 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> I don't think this is probably the right way to go. There could be two
> improvements:
>
> 1. move mfpr register manipulation into a dedicated function, e.g.
> ? ?mmp2_clear_pmic_int() within mmp2.c
>
> 2. invent a pmic_mask_ack_irq() to replace the default one at
> ? run-time, so to save the time that every 2nd level interrupt
> ? handling has to go through the if (.... == IRQ_MMP2_PMIC) thing,
> ? provided it does look like an ack operation to me.
>

Update this patch. The fix is in below.
1. add mmp2_clear_pmic_int()
2. append pmic_irq_demux2() for handling PMIC irq.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mmp2-add-handling-on-PMIC-IRQ.patch
Type: text/x-patch
Size: 2873 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100203/3415cd25/attachment.bin>
