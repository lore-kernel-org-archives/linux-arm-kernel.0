From: peter@hurleysoftware.com (Peter Hurley)
Date: Wed, 11 Mar 2015 12:30:37 -0400
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <5500502A.5060905@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru> <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <55003569.1010200@list.ru> <20150311124730.GZ8656@n2100.arm.linux.org.uk>
 <5500502A.5060905@list.ru>
Message-ID: <55006DAD.3070205@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 10:24 AM, Stas Sergeev wrote:
> However, while testing, I've suddenly got another crash happened
> a bit earlier than the previous one used to happen: (OOM? How??)
> ---

Probably related to these runaway modprobes.

> [    6.646259] request_module: runaway loop modprobe binfmt-0000
> [    6.653829] m25p80 spi0.0: n25q128a13 (16384 Kbytes)
> [    6.664246] request_module: runaway loop modprobe binfmt-0000

Regards,
Peter Hurley
