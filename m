From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 18 Feb 2013 20:58:11 +0100
Subject: [PATCH 1/9] ARM: fix ARCH_IXP4xx usage of ARCH_SUPPORTS_BIG_ENDIAN
In-Reply-To: <1360752927-29331-2-git-send-email-ben.dooks@codethink.co.uk>
 (Ben Dooks's message of "Wed, 13 Feb 2013 10:55:19 +0000")
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360752927-29331-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <m3mwv14coc.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> The Kconfig for arch/arm/mach-ixp4xx has a local definition
> of ARCH_SUPPORTS_BIG_ENDIAN which could be used elsewhere.
> This means that if IXP4xx is selected and this symbol is
> selected eleswhere then an warning is produced.
>
> Clean the following error up by making the symbol be
> selected by the main ARCH_IXP4XX definition and have a
> common definition in arch/arm/mm/Kconfig
>
> warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
> warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)

I don't know if the above would happen but as I think this isn't
IXP4xx-specific it should be defined by IXP4xx. At least ARM,
if not a "global" (we have other big endian ports).

The patch looks good enough to me.

>  arch/arm/Kconfig             |    1 +
>  arch/arm/mach-ixp4xx/Kconfig |    4 ----
>  arch/arm/mm/Kconfig          |    6 ++++++
>  3 files changed, 7 insertions(+), 4 deletions(-)
-- 
Krzysztof Halasa
