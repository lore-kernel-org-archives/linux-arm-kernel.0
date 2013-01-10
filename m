From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jan 2013 11:01:22 +0000
Subject: [PATCH v4 13/19] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1357235668-9450-14-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-14-git-send-email-robherring2@gmail.com>
Message-ID: <20130110110122.GB19944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 11:54:22AM -0600, Rob Herring wrote:
> -asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
> +static asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)

NAK.  No, not "static asmlinkage" which makes no sense.
