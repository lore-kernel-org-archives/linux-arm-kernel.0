From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 28 Feb 2011 16:01:33 +0530
Subject: [PATCH] davinci: cpufreq: fix section mismatch warning
In-Reply-To: <1298345033.3903.7.camel@mola>
References: <1298345033.3903.7.camel@mola>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BF35C9C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Tue, Feb 22, 2011 at 08:53:53, Axel Lin wrote:
> Fix below section mismatch warning:
> WARNING: vmlinux.o(.data+0x673c): Section mismatch in reference from the variable davinci_driver to the function .init.text:davinci_cpu_init()
> The variable davinci_driver references
> the function __init davinci_cpu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Will queue for Kevin to send upstream.

Thanks,
Sekhar
