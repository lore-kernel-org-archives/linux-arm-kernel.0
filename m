From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 06 Jul 2016 16:29:18 -0300
Subject: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
In-Reply-To: <20160706075226.27609-9-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-9-takahiro.akashi@linaro.org>
Message-ID: <6483018.WWW2TSJB10@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 06 Juli 2016, 16:52:26 schrieb AKASHI Takahiro:
> +linux,usable-memory
> +-------------------
> +
> +This property is set on PowerPC and arm64 by kexec-tools during kdump
> +to tell the crash kernel the base address of its reserved area of memory,
> and +the size. e.g.
> +
> +/ {
> +	chosen {
> +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> +	};
> +};

Again, this description is wrong for PowerPC. See messages from myself and 
Michael Ellerman:

https://lists.infradead.org/pipermail/kexec/2016-June/016250.html

https://lists.infradead.org/pipermail/kexec/2016-June/016253.html

IMHO, it would be simpler if ARM used linux,usable-memory in the same way 
that PowerPC does, for consistency.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
