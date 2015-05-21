From: tj@kernel.org (Tejun Heo)
Date: Thu, 21 May 2015 17:38:47 -0400
Subject: [PATCH] ata: hpt366: fix constant cast warning
In-Reply-To: <2549322.XbiTlcDvMS@wuerfel>
References: <2549322.XbiTlcDvMS@wuerfel>
Message-ID: <20150521213847.GB4914@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 04:34:05PM +0200, Arnd Bergmann wrote:
> gcc-5.x warns about a preexisting problem in the hpt36x pata driver:
> 
> drivers/ata/pata_hpt366.c: In function 'hpt36x_init_one':
> drivers/ata/pata_hpt366.c:376:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-array-qualifiers]
> 
> Other ata drivers have the same problem, as ata_pci_bmdma_init_one
> takes a non-const pointer, and they solve it by using a cast to
> turn that pointer into a normal non-const pointer.
> 
> I also tried to change the ata core code to make host->private_data
> a const pointer, but that quickly got out of hand, as some other
> drivers expect it to be writable, so I ended up using the same
> hack as the others here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to libata/for-4.2.

Thanks.

-- 
tejun
