From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Nov 2018 11:32:52 +0900
Subject: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
Message-ID: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,


On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.


Thanks for this work!


I applied this series, and it is available at

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kconfig2


I made local fixups in some parts,
where I left comments in individual patches.





> Changes since v3:
>  - drop the patches already merged
>  - fix a typo in the PCI help text
>  - split the always enable PCI on alpha change into a separate patch
>  - remove the mips HT_PCI symbol
>  - add a new FORCE_PCI symbol to easily allow selecting PCI support
>  - new patch to consolidate PCI_DOMAINS
>  - new patch to consolidate PCI_SYSCALL
>
> Changes since v2:
>  - depend on HAVE_PCI for PCIe endpoint code
>  - fix some commit message typos
>  - remove CONFIG_PCI from xtensa iss defconfig
>  - drop EISA support from arm
>  - clean up EISA selection for alpha
>
> Changes since v1:
>  - rename all HAS_* Kconfig symbols to HAVE_*
>  - drop the CONFIG_PCI_QSPAN option entirely
>  - drop duplicate select from powerpc
>  - restore missing selection of PCI_MSI for riscv
>  - update x86 and riscv defconfigs to include PCI
>  - actually inclue drivers/eisa/Kconfig
>  - adjust some captilizations



--
Best Regards
Masahiro Yamada
