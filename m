From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Apr 2013 09:54:02 -0600
Subject: Kexec couldn't reboot capture kernel on pandaboard ES with
 OMAP4460
In-Reply-To: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
References: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
Message-ID: <51658B1A.6090706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 03:35 AM, Li Haifeng wrote:
> Hi, everyone.
> 
> Recently, I try to run kdump on pandaboard ES with omap4460. After
> load capture kernel by "kexec -l" and execute "kexec -e", the serial
> port output "Starting new kernel" and "Bye", then the system hangs up.
> 
> I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.

This is a shot in the dark. I assume you have SMP enabled. Can you use
hotplug to remove all CPUs other than CPU0, so that the kexec happens on
the boot CPU? That is certainly necessary for kexec to work correctly on
Tegra.
