From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 16 May 2012 17:36:30 +0800
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120516185045.2f9e9274f373d584fd499eb2@canb.auug.org.au>
References: <20120516185045.2f9e9274f373d584fd499eb2@canb.auug.org.au>
Message-ID: <CAN1soZzBZUoCR5KgXbWBKAnxaR92CKFWqNMNLnm-dAD3xoH6yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 4:50 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/Kconfig between commit 98fab064d321 ("ARM: Remove unnecessary
> selection of TICK_ONESHOT") from the arm tree and commit c24b31147a06
> ("ARM: mmp: support DT in irq") from the arm-soc tree.
>
> Just context changes. ?I fixed it up (see below) and can carry the fix as
> necessary.
> --
> Cheers,
> Stephen Rothwell ? ? ? ? ? ? ? ? ? ?sfr at canb.auug.org.au
>
> diff --cc arch/arm/Kconfig
> index b1a717c,852b12b..0000000
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@@ -627,6 -616,8 +611,7 @@@ config ARCH_MM
> ? ? ? ?select CLKDEV_LOOKUP
> ? ? ? ?select GENERIC_CLOCKEVENTS
> ? ? ? ?select GPIO_PXA
> + ? ? ? select IRQ_DOMAIN
> ?- ? ? ?select TICK_ONESHOT
> ? ? ? ?select PLAT_PXA
> ? ? ? ?select SPARSE_IRQ
> ? ? ? ?select GENERIC_ALLOCATOR

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
