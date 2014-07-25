From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jul 2014 14:45:21 +0100
Subject: arm64 Kernel is overly verbose on user faults
In-Reply-To: <CAAqcGHkjgOfs1Yj3SNmjpzE2cdGTh4EQ0njyka6UaeVVnbvQGw@mail.gmail.com>
References: <CAAqcGHkjgOfs1Yj3SNmjpzE2cdGTh4EQ0njyka6UaeVVnbvQGw@mail.gmail.com>
Message-ID: <20140725134520.GJ24268@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 01:22:49PM +0100, Riku Voipio wrote:
> Arm64 kernel dmesg will print out a multiline message if any user
> binary segfaults. We get "unhandled level X translation fault" with
> pr_info, show_pte() with pr_alert and show_regs with default kernel
> level:

I agree show_pte() is not useful for user debugging but I'm not sure
about show_regs(), it may come in handy when debugging some user
application.

We could hide the extra information like show_pte behind a
CONFIG_DEBUG_USER while keeping the short reporting as it currently is
(based on show_unhandled_signals).

-- 
Catalin
