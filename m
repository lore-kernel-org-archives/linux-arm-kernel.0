From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 3 Aug 2015 12:24:53 +0200
Subject: [Query] ARM64: Softlockup when using PSCI for secondary CPU_ON
In-Reply-To: <BY1PR0301MB1303EC5AAE8F0B4DAA70D15F82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <BY1PR0301MB1303EC5AAE8F0B4DAA70D15F82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <CAKv+Gu8i-HC7zb-CuCaVE5vcoEO6T19_=s3JtHqnNHaUmdwQqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2015 at 06:12, Sharma Bhupesh <bhupesh.sharma@freescale.com> wrote:
> Hi ARM64 experts,
>
> I am working on a Freescale ARM64 based SoC, which has 4 Cortex-A53 cores and I am using the
> PSCI conducts to turn on the secondary CPUs via a custom implementation of a secure runtime
> firmware (something similar to the ARM Trusted Firmware).
>
> Following is my boot-flow:
>
> - BootROM (runs in EL3, All secondaries are held up in reset) ->
>
> - UEFI bootloader- PEI Phase (Runs only on Primary, starts up in EL3) ->
>
> - Secure Firmware (runs in EL3, transitions primary core to EL2) ->
>
> - UEFI bootloader- Rest of the Phases (Runs only on Primary, in EL2) ->
>
> - UEFI Linux loader launches linux (Runs only on Primary, transitions core to EL1) ->
>

Why are you using the Linux loader? The arm64 kernel can be booted
directly from UEFI, which is strongly preferred since you will not
have access to the UEFI Runtime Services otherwise.
Also, the ARM BDS and the LinuxLoader for arm64 in Tianocore/EDK2 are
quite badly broken and may be removed completely in the future.

-- 
Ard.
