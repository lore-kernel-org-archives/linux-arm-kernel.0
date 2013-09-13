From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Sep 2013 13:13:22 +0100
Subject: [PATCH 5/5] ARM64: Add support for ILP32 ABI.
In-Reply-To: <20130913100453.GB21859@mudshark.cambridge.arm.com>
References: <1378762380-13152-1-git-send-email-apinski@cavium.com>
 <1378762380-13152-5-git-send-email-apinski@cavium.com>
 <20130911143102.GA8825@darko.cambridge.arm.com>
 <CA+=Sn1nd3Ym8so_=SP4NC1fjKWn4dNPYvz4OZMo0tLZptF8KVw@mail.gmail.com>
 <20130913094712.GA21859@mudshark.cambridge.arm.com>
 <20130913095739.GB10385@arm.com>
 <20130913100453.GB21859@mudshark.cambridge.arm.com>
Message-ID: <20130913121322.GD10385@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 11:04:53AM +0100, Will Deacon wrote:
> On Fri, Sep 13, 2013 at 10:57:40AM +0100, Catalin Marinas wrote:
> > On Fri, Sep 13, 2013 at 10:47:12AM +0100, Will Deacon wrote:
> > > On Fri, Sep 13, 2013 at 07:18:48AM +0100, Andrew Pinski wrote:
> > > > On Wed, Sep 11, 2013 at 7:32 AM, Catalin Marinas
> > > > <catalin.marinas@arm.com> wrote:
> > > > > On Mon, Sep 09, 2013 at 10:32:59PM +0100, Andrew Pinski wrote:
> > > > >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > >> index cc64df5..7fdc994 100644
> > > > >> --- a/arch/arm64/Kconfig
> > > > >> +++ b/arch/arm64/Kconfig
> > > > >> @@ -248,7 +248,7 @@ source "fs/Kconfig.binfmt"
> > > > >>
> > > > >>  config COMPAT
> > > > >>         def_bool y
> > > > >> -       depends on ARM64_AARCH32
> > > > >> +       depends on ARM64_AARCH32 || ARM64_ILP32
> > > > >>         select COMPAT_BINFMT_ELF
> > > > >>
> > > > >>  config ARM64_AARCH32
> > > 
> > > (nitpick) We used to have an option like this, called
> > > CONFIG_AARCH32_EMULATION, which I think is clearer than CONFIG_ARM64_AARCH32.
> > 
> > I think avoiding "EMULATION" is better, we don't actually emulate the
> > instruction set ;).
> 
> Bah, you suggest something better then!

CONFIG_AARCH32_EL0.

-- 
Catalin
