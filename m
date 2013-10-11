From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 Oct 2013 09:45:11 -0600
Subject: Arm errata 752520
In-Reply-To: <20131011105401.443ccdc1@parrot.com>
References: <20131011105401.443ccdc1@parrot.com>
Message-ID: <52581D07.8020206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2013 02:54 AM, Matthieu CASTET wrote:
> Hi,
> 
> tegra kernel on android tree have a workaround for cortex A9 errata
> 752520 :

You probably wanted to email the Tegra maintainers and list.

> "ARM: errata: 752520: Faulty arbitration between PLD and Cacheable TLB
> requests may create a system deadlock."
> https://android.googlesource.com/kernel/tegra/+/eabc12e1afe0bfc2f9e6f7bacae03985439df1a2%5E!/#F1
> 
> But this errata is not in mainline kernel. Do you know why ?
> Should a patch be submitted to add it ?

Looking at that link, the WAR is enabled in the CPU's diagnostic
register, and IIRC, writes to that register are only possible from
secure mode. Since the Linux kernel does not always run in secure mode,
and has no way of detecting whether it is, it cannot implement the WAR.
Instead, the bootloader or secure firmware must do this before booting
the kernel.

> PS : There is also another patch for errata 720791.

I assume there are similar limits on the "chicken power ctrl" register,
whatever that is! (name take from the same kernel source tree you linked
to above).
