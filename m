From: rabin@rab.in (Rabin Vincent)
Date: Thu, 24 Apr 2014 17:43:20 +0200
Subject: [PATCH] ARM: fix string functions on !MMU
In-Reply-To: <20140422094424.GA6979@arm.com>
References: <1398103808-24380-1-git-send-email-rabin@rab.in>
 <20140422094424.GA6979@arm.com>
Message-ID: <20140424154320.GA4129@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 10:44:24AM +0100, Will Deacon wrote:
> On Mon, Apr 21, 2014 at 07:10:08PM +0100, Rabin Vincent wrote:
> > 8c56cc8be5b38e ("ARM: 7449/1: use generic strnlen_user and
> > strncpy_from_user functions") apparently broken those string operations
> > for !MMU.  USER_DS == KERNEL_DS on !MMU, so user_addr_max() always
> > restricts the addresses to TASK_SIZE.
> > 
> > TASK_SIZE has anyway no meaning on !MMU, so make user_addr_max() not
> > restrict anything.
> 
> Might be worth mentioning that this is an issue because KERNEL_DS is 0x0
> (since it's a 32-bit quantity), so checks like addr < user_addr_max() will
> fail.

Thanks for the ack, but I don't quite understand what you mean here.
You describe the state before this patch, right?  Why does it matter
that KERNEL_DS is 0x0?
