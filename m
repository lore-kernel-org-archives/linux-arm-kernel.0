From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Jan 2018 10:15:08 -0800
Subject: [BISECTED] kexec issue with v4.15-rc on N8x0
In-Reply-To: <20180111194747.k5qwz66mfntj6v2g@darkstar.musicnaut.iki.fi>
References: <20180111194747.k5qwz66mfntj6v2g@darkstar.musicnaut.iki.fi>
Message-ID: <20180115181508.GM4821@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Aaro Koskinen <aaro.koskinen@iki.fi> [180111 11:48]:
> Hi,
> 
> When booting v4.15-rc kernel with kexec (kexec-tools 2.0.16) on N8x0, I get:
> 
>     Uncompressing Linux... done, booting the kernel.
>     no ATAGS support: can't continue
> 
> v4.14 kernel works OK.
> 
> I bisected this to:
> 
> commit c772568788b5f0cbaac7c8d4111d7173bfc90673
> Author: Russell King <rmk+kernel@armlinux.org.uk>
> Date:   Thu Sep 21 18:10:19 2017 +0100
> 
>     ARM: add additional table to compressed kernel
> 
> If I revert the commit, kexec booting starts to work. Interesting,
> the patch mentions "This is necessary for correct behaviour of kexec.",
> so I wonder what could be wrong...

So care to post what you get if you load with kexec -d -l options
before and after this commit?

Also, I wonder if Linux next commit 55e7cff44c7c ("ARM: verify
size of zImage") helps here?

Regards,

Tony
