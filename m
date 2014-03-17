From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 15:37:19 +0100
Subject: [PATCH v2] CNS3xxx: Fix PCIe early iotable_init().
In-Reply-To: <m3eh2inxef.fsf@t19.piap.pl>
References: <m3eh2nqz7n.fsf@t19.piap.pl> <m3r46io1nd.fsf@t19.piap.pl>
 <m3eh2inxef.fsf@t19.piap.pl>
Message-ID: <201403171537.19546.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 March 2014, Krzysztof Ha?asa wrote:
> khalasa at piap.pl (Krzysztof Ha?asa) writes:
> 
> > This patch fixes the following BUG:
> >
> >> kernel BUG at mm/vmalloc.c:1132!
> >> PC is at vm_area_add_early+0x20/0x84
> >> LR is at add_static_vm_early+0xc/0x60
> >>
> >> The problem is cns3xxx_pcie_init() (device_initcall) calls the "early"
> >> iotable_init().
> 
> That's obviously:
> 
> Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
> 

Applied to next/fixes-non-critical.

Since the problem is not new and you didn't mark the patch as 'stable',
this seems to be the right place. Let us know if you need backports
to stable kernels, also fo the other patch.

In general, when submitting arm-soc patches for inclusion, please add
arm at kernel.org to Cc, so we don't miss it.

Thanks,

	Arnd
