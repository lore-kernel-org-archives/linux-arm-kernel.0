From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 11 Apr 2013 21:38:53 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gR1BJTzogZ3Bpby1nZW5lcmljOiBSZW1vdmUga2Zy?=
 =?UTF-8?B?ZWUoKSBmcm9tIGJncGlvX3JlbW92ZSBjYWxs?=
References: <1365701002-17292-1-git-send-email-shc_work@mail.ru>
Message-ID: <1365701933.646047659@f77.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Apr 11, 2013 at 7:23 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> > Memory for basic-mmio-gpio driver is allocated by resource managed
> > function, so using kfree() call in bgpio_remove is wrong.
> > This patch eliminates this kfree() call.
> >
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> So I think the patch is correct but the commit message is wrong.
> 
> It is not certain at all that bgpio is resource managed, but the point
> of the patch should be that it's up to the driver using it to allocate
> and free its struct bgpio_chip, after calling this function.
> 
> A quick glance on the consumers gives at hand that this is the case
> for all consumers, so I took the liberty to update the commit
> message and apply it...

OK, no problem.

---
