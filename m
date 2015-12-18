From: bhupesh.linux@gmail.com (Bhupesh SHARMA)
Date: Fri, 18 Dec 2015 11:52:07 +0530
Subject: [PATCH v3 0/2] ARM64: Enable SP805 WDT support for FSL LS2080A
In-Reply-To: <1450189825-29065-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1450189825-29065-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <CAFTCetRhHwgg1w=gYHL0T=8p-KVV1sq_jVK1CmHr3DF1Ng=UDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Mark,

On Tue, Dec 15, 2015 at 8:00 PM, Bhupesh Sharma
<bhupesh.sharma@freescale.com> wrote:
> This is the v3 of patchset which adds the support for SP805 WDT on FSL LS2080A
> and also adds the missing documentation of SP805 WDT device-tree bindings.

Any comments on this version, or does it seems fine for integration
into the arm-soc tree.

Regards,
Bhupesh

>
> Rebased against arm-soc/next/dt
>
> Changes since v2:
> (v2 can be viewed here: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/463141)
> - Addressed Rob's comments regarding the second mandatory CLK source's
>   (WDOGCLK) name in the bindings.
>
> Changes since v1:
> (v1 can be viewed here: http://www.spinics.net/lists/devicetree/msg102487.html)
>
> - Addressed Rob and Mark's comments regarding the mandatory CLK sources
> - Removed interrupt property from the bindings for now (as discussed
>   with Mark on IRC) till Will's patch proceeds further and enables
>   handling the WDOG interrupts for each core connected to the same PPI
>   line (http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/391616.html)
>
> Bhupesh Sharma (2):
>   Documentation: DT: Add entry for ARM SP805-WDT
>   dts/ls2080a: Update DTSI to add support of SP805 WDT
>
>  .../devicetree/bindings/watchdog/sp805-wdt.txt     |   29 ++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   56 ++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>
> --
> 1.7.9.5
>
