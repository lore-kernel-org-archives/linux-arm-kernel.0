From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 09:45:51 +0200
Subject: [PATCH v7 05/10] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <alpine.DEB.2.11.1410210941100.5308@nanos>
References: <1413875672-7894-1-git-send-email-linux@rempel-privat.de>
 <1413875672-7894-6-git-send-email-linux@rempel-privat.de>
 <alpine.DEB.2.11.1410210924140.5308@nanos>
 <54460C91.5020503@rempel-privat.de>
 <alpine.DEB.2.11.1410210941100.5308@nanos>
Message-ID: <54460F2F.2080306@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.10.2014 um 09:42 schrieb Thomas Gleixner:
> On Tue, 21 Oct 2014, Oleksij Rempel wrote:
> 
>> Am 21.10.2014 um 09:27 schrieb Thomas Gleixner:
>>> On Tue, 21 Oct 2014, Oleksij Rempel wrote:
>>>>  static void icoll_unmask_irq(struct irq_data *d)
>>>>  {
>>>> -	__raw_writel(BM_ICOLL_INTR_ENABLE,
>>>> -			icoll_priv.intr + SET_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
>>>> +	mutex_lock(&icoll_lock);
>>>
>>> And how's that supposed to work? You certainly did not run this code
>>> with even the simplest debugging options enabled. Not to talk about
>>> lockdep or such.
>>
>> Are there any check list what debugging options should be enabled?
> 
> # ls Documentation | grep -i checklist
> 
> Perhaps?

Thank you. Will recheck it.
I used this one
http://free-electrons.com/pub/conferences/2012/elce/arm-soc-checklist/arm-soc-checklist.pdf


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/9f580c22/attachment.sig>
