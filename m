From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Wed, 18 Apr 2018 12:01:54 +0200
Subject: [PATCH v6 05/11] ARM: smp: Add initialization of CNTVOFF
In-Reply-To: <CAMuHMdWFyLCQb=c=gnWokxGFtsQF2i+s1nPWtJJmZPXAQjnu4g@mail.gmail.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-6-mylene.josserand@bootlin.com>
 <CAMuHMdWFyLCQb=c=gnWokxGFtsQF2i+s1nPWtJJmZPXAQjnu4g@mail.gmail.com>
Message-ID: <20180418120154.28fe6c4c@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

On Wed, 18 Apr 2018 11:30:47 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Allo Myl?ne,
> 
> On Mon, Apr 16, 2018 at 11:50 PM, Myl?ne Josserand
> <mylene.josserand@bootlin.com> wrote:
> > The CNTVOFF register from arch timer is uninitialized.
> > It should be done by the bootloader but it is currently not the case,
> > even for boot CPU because this SoC is booting in secure mode.
> > It leads to an random offset value meaning that each CPU will have a
> > different time, which isn't working very well.
> >
> > Add assembly code used for boot CPU and secondary CPU cores to make
> > sure that the CNTVOFF register is initialized. Because this code can
> > be used by different platforms, add this assembly file in ARM's common
> > folder.  
> 
> Thanks for your patch!
> 
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Great, thank you very much for your test!

Best regards,

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
