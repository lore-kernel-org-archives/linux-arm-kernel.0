From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 10:15:11 +0000
Subject: [PATCH v2] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <CAKv+Gu8GjkHedjjSxT0ctankmLNBH4+CjsfjPV9UuEOkrzSJ5w@mail.gmail.com>
References: <1425556302-3370-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150309180645.GD8656@n2100.arm.linux.org.uk>
 <CAKv+Gu8yDK_U_J-yeA4QRypNT=TKjxNtkyiKnJaogacDt5_jrw@mail.gmail.com>
 <CAKv+Gu8GjkHedjjSxT0ctankmLNBH4+CjsfjPV9UuEOkrzSJ5w@mail.gmail.com>
Message-ID: <20150310101511.GI8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 07:38:01PM +0100, Ard Biesheuvel wrote:
> Replying to self: looking at the arm64 code, it seems the 4-bit block
> are signed quantities, and the negative valiues are reserved.
> This means only signed higher values should be considered incremental,
> and values with bit 4 set should be ignored.

ITYM bit 3.

On 32-bit, we've assumed that they're unsigned:

        /* LPAE implies atomic ldrd/strd instructions */
        vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
        if (vmsa >= 5)
                elf_hwcap |= HWCAP_LPAE;

        sync_prim = ((read_cpuid_ext(CPUID_EXT_ISAR3) >> 8) & 0xf0) |
                    ((read_cpuid_ext(CPUID_EXT_ISAR4) >> 20) & 0x0f);
        if (sync_prim >= 0x13)
                elf_hwcap &= ~HWCAP_SWP;

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
