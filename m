From: dwalker@codeaurora.org (Daniel Walker)
Date: Sun, 31 Jan 2010 05:31:30 -0800
Subject: [PATCH] staging/dream: add missing include files/fix compilation
In-Reply-To: <20100131084421.GG2238@elf.ucw.cz>
References: <20091225205917.GA25761@elf.ucw.cz>
	<20100115002419.GA25643@kroah.com> <20100119054516.GB22153@elf.ucw.cz>
	<1263914079.1951.43.camel@m0nster> <20100131084421.GG2238@elf.ucw.cz>
Message-ID: <1264944690.2059.2.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-01-31 at 09:44 +0100, Pavel Machek wrote:

> arch/arm/mach-msm/rpc_hsusb.c: In function 'msm_chg_rpc_connect':
> arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
> function 'machine_is_msm7201a_surf'
> arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
> function 'machine_is_msm7x27_surf'
> arch/arm/mach-msm/rpc_hsusb.c:157: error: implicit declaration of
> function 'machine_is_qsd8x50_surf'
> make[1]: *** [arch/arm/mach-msm/rpc_hsusb.o] Error 1
> make: *** [arch/arm/mach-msm] Error 2
> 
> (and similar error further down). This fixes it, but you probably want
> to add machine_is_* to your git. (Aha, is that what you meant by
> "machine types"?

Yeah, those machines aren't registered so the inlines don't get
generated .. 

> With this patch it compiles.

I need to actually register those machine types, So I can't remove them.
They are valid boards.

Daniel
