From: lukasz.goralczyk@gmail.com (=?UTF-8?Q?=C5=81ukasz_G=C3=B3ralczyk?=)
Date: Sun, 30 May 2010 22:37:59 +0200
Subject: Problem with at91_mci and AT91RM9200
In-Reply-To: 1274966669.2465.105.camel@arcturus
References: 1274966669.2465.105.camel@arcturus
Message-ID: <1275251879.2380.2.camel@arcturus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-05-27 13:24, ?ukasz G?ralczyk wrote:
[cut]
> I compiled newest kernel (2.6.33.4 and 2.6.32 with at91 patches
> http://www.at91.com/linux4sam/bin/view/Linux4SAM/LinuxKernel#AT91_Linux_kernel_sources_summar )
> which boots but fails to detect SD Card (Sandisk microSD 2 GB through SD
> adapter). A the end there's a debugging output (stripped, full:
> http://liku.ayz.pl/at91mmc ).
[cut]

Solution is to lower clock speed from 400k Hz to 150k Hz (350k and 300k
didn't work) in drivers/mmc/core/core.c around line 915.

Lukasz.
