From: robherring2@gmail.com (Rob Herring)
Date: Thu, 10 Jan 2013 08:38:28 -0600
Subject: [PATCH v4 07/19] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <20130110110205.GC19944@n2100.arm.linux.org.uk>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-8-git-send-email-robherring2@gmail.com>
 <20130110110205.GC19944@n2100.arm.linux.org.uk>
Message-ID: <50EED264.1020709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 05:02 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 03, 2013 at 11:54:16AM -0600, Rob Herring wrote:
>> -asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>> +static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
> 
> NAK.  No, not "static asmlinkage".

Okay will remove asmlinkage, but is there an issue with making this static?

Rob
