From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 28 Nov 2012 14:26:10 +1100
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma
 tree
In-Reply-To: <CAKohpo=K2kX-M4NM9onrn-Rr4otJwcQ1HxN5cKPYvj+Tza_0Ug@mail.gmail.com>
References: <20121127154430.36e87542081a7cc50f80d0f6@canb.auug.org.au>
 <CAKohpo=K2kX-M4NM9onrn-Rr4otJwcQ1HxN5cKPYvj+Tza_0Ug@mail.gmail.com>
Message-ID: <20121128142610.9fdfaf75a98ef83a12c32d9b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 27 Nov 2012 11:08:36 +0530 Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27 November 2012 10:14, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/mach-spear13xx/spear1310.c between commit b47394911c26 ("ARM:
> > SPEAr13xx: Pass DW DMAC platform data from DT") from the slave-dma tree
> > and commit 300a6856324a ("ARM: SPEAr1310: Fix AUXDATA for compact flash
> > controller") from the arm-soc tree.
> >
> > I have no idea how to fix this up, so I just effectively dropped the
> > arm-doc tree patch.
> 
> So sorry for that, Can you please take arm-soc version here? Patch 300a6856324a
> is doing the correct thing. i.e. we need
> 
> +       OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_pdata),
> 
> instead of
> 
> +       OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, "cf"),

Done, it should be correct on today's linux-next.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/c6a70176/attachment.sig>
