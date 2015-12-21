From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 12:21:48 +0000
Subject: [PATCH v8 9/4] arm64: remove irq_count and do_softirq_own_stack()
In-Reply-To: <DB3PR08MB0041F2F26E5FABEE61ACA089F3E40@DB3PR08MB0041.eurprd08.prod.outlook.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1450454507-8907-1-git-send-email-james.morse@arm.com>
 <68E0E2C7-A4C2-45C2-95C5-842FA807F918@gmail.com>
 <20151221113021.GH23092@arm.com>
 <DB3PR08MB0041F2F26E5FABEE61ACA089F3E40@DB3PR08MB0041.eurprd08.prod.outlook.com>
Message-ID: <20151221122148.GK23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 12:19:32PM +0000, James Morse wrote:
> Will Deacon wrote:
> >> > +   mrs     x26, sp_el0             // already masked
> >>
> >> Nit: How about using 'get_thread_info x26'?
> > 
> > Something like the following?
> 
> Looks fine - I guess you're cleverly leaving the the el0_irq case to be
> covered by get_thread_info in kernel_entry?

Yup. tsk is always valid for exceptions taken from el0, afaict.

Will
