From: balbi@kernel.org (Felipe Balbi)
Date: Mon, 26 Sep 2016 10:18:33 +0300
Subject: [PATCH] usb: gadget: udc: atmel: fix endpoint name
In-Reply-To: <20160923150323.GB13744@kroah.com>
References: <20160915150722.13103-1-alexandre.belloni@free-electrons.com>
 <c90099af-2537-cc41-2775-dd2ca41dc070@atmel.com>
 <331f5819-1f65-980d-486d-732342877f2c@atmel.com>
 <20160923150323.GB13744@kroah.com>
Message-ID: <874m535dti.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Fri, Sep 23, 2016 at 04:20:45PM +0200, Nicolas Ferre wrote:
>> Le 16/09/2016 ? 10:36, Nicolas Ferre a ?crit :
>> > Le 15/09/2016 ? 17:07, Alexandre Belloni a ?crit :
>> >> Since commit c32b5bcfa3c4 ("ARM: dts: at91: Fix USB endpoint nodes"),
>> >> atmel_usba_udc fails with:
>> >>
>> >> ------------[ cut here ]------------
>> >> WARNING: CPU: 0 PID: 0 at include/linux/usb/gadget.h:405
>> >> ecm_do_notify+0x188/0x1a0
>> >> Modules linked in:
>> >> CPU: 0 PID: 0 Comm: swapper Not tainted 4.7.0+ #15
>> >> Hardware name: Atmel SAMA5
>> >> [<c010ccfc>] (unwind_backtrace) from [<c010a7ec>] (show_stack+0x10/0x14)
>> >> [<c010a7ec>] (show_stack) from [<c0115c10>] (__warn+0xe4/0xfc)
>> >> [<c0115c10>] (__warn) from [<c0115cd8>] (warn_slowpath_null+0x20/0x28)
>> >> [<c0115cd8>] (warn_slowpath_null) from [<c04377ac>] (ecm_do_notify+0x188/0x1a0)
>> >> [<c04377ac>] (ecm_do_notify) from [<c04379a4>] (ecm_set_alt+0x74/0x1ac)
>> >> [<c04379a4>] (ecm_set_alt) from [<c042f74c>] (composite_setup+0xfc0/0x19f8)
>> >> [<c042f74c>] (composite_setup) from [<c04356e8>] (usba_udc_irq+0x8f4/0xd9c)
>> >> [<c04356e8>] (usba_udc_irq) from [<c013ec9c>] (handle_irq_event_percpu+0x9c/0x158)
>> >> [<c013ec9c>] (handle_irq_event_percpu) from [<c013ed80>] (handle_irq_event+0x28/0x3c)
>> >> [<c013ed80>] (handle_irq_event) from [<c01416d4>] (handle_fasteoi_irq+0xa0/0x168)
>> >> [<c01416d4>] (handle_fasteoi_irq) from [<c013e3f8>] (generic_handle_irq+0x24/0x34)
>> >> [<c013e3f8>] (generic_handle_irq) from [<c013e640>] (__handle_domain_irq+0x54/0xa8)
>> >> [<c013e640>] (__handle_domain_irq) from [<c010b214>] (__irq_svc+0x54/0x70)
>> >> [<c010b214>] (__irq_svc) from [<c0107eb0>] (arch_cpu_idle+0x38/0x3c)
>> >> [<c0107eb0>] (arch_cpu_idle) from [<c0137300>] (cpu_startup_entry+0x9c/0xdc)
>> >> [<c0137300>] (cpu_startup_entry) from [<c0900c40>] (start_kernel+0x354/0x360)
>> >> [<c0900c40>] (start_kernel) from [<20008078>] (0x20008078)
>> >> ---[ end trace e7cf9dcebf4815a6 ]---
>> >>
>> >> Fixes: c32b5bcfa3c4 ("ARM: dts: at91: Fix USB endpoint nodes")
>> >> Reported-by: Richard Genoud <richard.genoud@gmail.com>
>> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> > 
>> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> > 
>> > Felipe, Greg,
>> > It is clearly a regression and material for 4.8-fixes. But I do know
>> > that we are very late in the process :-(
>> > Please do what you can to make it progress before 4.8-final but I'm
>> > truly aware of the challenge.
>> 
>> Any chance that we can have it (aka ping)?
>
> It's Felipe's area, not mine :)

Sorry, I had missed this one. Greg, seems like this would be the only
pending fix. Do you want it in a pull request or would you prefer to
just pick it up as a patch? Works either way for me. In case you decide
to pick it up as a patch:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

If you prefer to pick it up as a pull request, I already have the patch
in my 'fixes' branch, just need to tag it and send it to you.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160926/244552d8/attachment.sig>
