From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 21 Nov 2016 09:26:23 -0600
Subject: [PATCH] ARM: dts: socfpga: fine-tune L2 cache configuration
In-Reply-To: <20161118185218.16653-1-marex@denx.de>
References: <20161118185218.16653-1-marex@denx.de>
Message-ID: <c9f7f582-ca98-a83f-24cf-a6793b2ae7bd@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 11/18/2016 12:52 PM, Marek Vasut wrote:
> Enable double-linefill and increase prefetch offset, which gives
> considerable read performance boost. The following numbers were
> obtained using lmbench 3.0 bw_mem tool, for easier comparison, the
> numbers are pasted in two columns. The test machine has Cyclone V
> SoC running at 800MHz MPU clock and 512MiB 333MHz 16bit DDR3 DRAM.
> 
> Without patch	| With patch
> $ for i in rd wr rdwr cp fwr frd fcp bzero bcopy ; do echo $i ; bw_mem 64M $i ; done
> rd		| rd
> 64.00 526.46	| 64.00 1151.06
> wr		| wr
> 64.00 329.95	| 64.00 346.14
> rdwr		| rdwr
> 64.00 342.07	| 64.00 367.24
> cp		| cp
> 64.00 239.79	| 64.00 322.47
> fwr		| fwr
> 64.00 1027.90	| 64.00 1025.38
> frd		| frd
> 64.00 322.36	| 64.00 641.89
> fcp		| fcp
> 64.00 256.99	| 64.00 408.41
> bzero		| bzero
> 64.00 1028.43	| 64.00 1025.07
> bcopy		| bcopy
> 64.00 294.73	| 64.00 357.19
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>

Applied!

Thanks,
Dinh
