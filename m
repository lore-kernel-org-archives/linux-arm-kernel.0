From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Feb 2017 17:38:45 +0100
Subject: [PATCH] ARM: defconfigs: make NF_CT_PROTO_SCTP and
 NF_CT_PROTO_UDPLITE built-in
In-Reply-To: <20170203164647.3610978-1-arnd@arndb.de>
References: <20170203164647.3610978-1-arnd@arndb.de>
Message-ID: <CAK8P3a0ms69LLevt5oamJ5h6S3o-Rm_RtR=YCdayU3v+7BCdzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2017 at 5:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The symbols can no longer be used as loadable modules, leading to a harmless Kconfig
> warning:
>
> arch/arm/configs/imote2_defconfig:60:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
> arch/arm/configs/imote2_defconfig:59:warning: symbol value 'm' invalid for NF_CT_PROTO_SCTP
> arch/arm/configs/ezx_defconfig:68:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
> arch/arm/configs/ezx_defconfig:67:warning: symbol value 'm' invalid for NF_CT_PROTO_SCTP
>
> Let's make them built-in.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Added to the fixes branch now, as I see the warnings in kernelci for ARM.

    Arnd
