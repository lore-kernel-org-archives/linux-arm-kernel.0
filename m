From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Mon, 2 Aug 2010 11:21:23 +0200
Subject: several section mismatches
Message-ID: <201008021121.23860.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seems that we have some problems with g_ether and pxa cpufreq. This is problematic output of `make CONFIG_DEBUG_SECTION_MISMATCH=y':

WARNING: vmlinux.o(.data+0x2e18): Section mismatch in reference from the variable pxa_cpufreq_driver to the function .init.text:pxa_cpufreq_init()
The variable pxa_cpufreq_driver references
the function __init pxa_cpufreq_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: vmlinux.o(.data+0x1e514): Section mismatch in reference from the variable eth_config_driver to the function .init.text:eth_do_config()
The variable eth_config_driver references
the function __init eth_do_config()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 

WARNING: vmlinux.o(.data+0x1e6f0): Section mismatch in reference from the variable eth_driver to the function .init.text:eth_bind()
The variable eth_driver references
the function __init eth_bind()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Best regards,

Tomas Cech
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100802/6c19f562/attachment.html>
