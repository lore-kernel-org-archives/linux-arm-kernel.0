From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Sep 2012 15:55:18 -0600
Subject: [PATCH 08/12] dtc: be more quiet with "make -s"
In-Reply-To: <1348868177-21205-9-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-9-git-send-email-arnd@arndb.de>
Message-ID: <50661CC6.2010007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 03:36 PM, Arnd Bergmann wrote:
> On a normal build, we get output from both make and from dtc
> about each file that is being processed.
> 
>   DTC     arch/arm/boot/vexpress-v2p-ca5s.dtb
> DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca5s.dts"
>   DTC     arch/arm/boot/vexpress-v2p-ca9.dtb
> DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca9.dts"
>   DTC     arch/arm/boot/vexpress-v2p-ca15-tc1.dtb
> DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts"
>   DTC     arch/arm/boot/vexpress-v2p-ca15_a7.dtb
> DTC: dts->dtb  on file "/git/arnd/linux-arm/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts"
> 
> When both lines refer to the same action. When building with "make -s",
> the "DTC: dts->dtb ..." line is the only output we currently get.
> 
> This patch makes dtc not output the message when the "-q" flag is passed,
> and ensures that we pass it in both cases.

Just as an FYI, the upstream dtc no longer prints this message, and I
just posted a patch to pull that whole upstream dtc into the kernel.
