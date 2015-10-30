From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 Oct 2015 00:28:52 +0100
Subject: [PATCH 2/2] sound: soc: Add Cygnus audio driver
In-Reply-To: <201510310722.jTEbgeBu%fengguang.wu@intel.com>
References: <201510310722.jTEbgeBu%fengguang.wu@intel.com>
Message-ID: <3878425.UJmmiCl69s@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 October 2015 07:20:17 kbuild test robot wrote:
>  > 785          dev_dbg(rtd->cpu_dai->dev, "%s: size 0x%x @ 0x%p\n",
>    786                                  __func__, size, buf->area);
> 

Both reports are for the same bug: the "0x%x" should be "0x%zx".

There is another bug in the same line: "0x%p" should be "%pK",
to avoid the duplicate "0x" and to not leak the pointer when
kptr_restrict is set.

	Arnd
