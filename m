From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 31 Aug 2010 21:44:16 +0530
Subject: [PATCH v1] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6AC5679@dbde02.ent.ti.com>
References: <4C7C52FD.6010608@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6AC5679@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6AC5699@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 21:09:20, Nori, Sekhar wrote:
> > @@ -586,6 +586,9 @@ static __init void da830_evm_init(void)
> >  #ifdef CONFIG_SERIAL_8250_CONSOLE
> >  static int __init da830_evm_console_init(void)
> >  {
> > +     if (!machine_is_davinci_da830_evm())
> > +             return 0;
> > +
> >       return add_preferred_console("ttyS", 2, "115200");
> >  }
> >  console_initcall(da830_evm_console_init);
> > diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> > index 190ebd3..d491b5f 100644
> > --- a/arch/arm/mach-davinci/board-da850-evm.c
> > +++ b/arch/arm/mach-davinci/board-da850-evm.c
> > @@ -847,6 +847,9 @@ static __init void da850_evm_init(void)
> >  #ifdef CONFIG_SERIAL_8250_CONSOLE
> >  static int __init da850_evm_console_init(void)
> >  {
> > +     if (!machine_is_davinci_da850_evm())
> > +             return 0;
> > +
> >       return add_preferred_console("ttyS", 2, "115200");
> >  }
> >  console_initcall(da850_evm_console_init);
>
> I think this should be carved into a separate patch as
> this is a bug fix of existing code rather than addition
> of new board as subject and description of this patch
> indicate.
>

Oops, missed seeing that Kevin already pointed this out.
Sorry about that.

Thanks,
Sekhar
