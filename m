From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 18:08:34 +0200
Subject: [GIT PULL 1/2] Broadcom soc changes for 4.15 (part 1)
In-Reply-To: <20170925190112.3915-1-f.fainelli@gmail.com>
References: <20170925190112.3915-1-f.fainelli@gmail.com>
Message-ID: <CAK8P3a2MooOH5j048TM7fhzk5h9aWuCjyU4_2BM9B5GJPEFrcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 9:01 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
>
> are available in the git repository at:
>
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/soc
>
> for you to fetch changes up to c14963521502b237a6817aceda6f3379296db75c:
>
>   ARM: brcmstb: Add appropriate ARM_BE8() macros for swapping (2017-09-25 11:56:04 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC/Kconfig changes for 4.15
> please pull the following:
>
> - Danilo removes the clock provider driver stubs which are no longer needed
>   now that we have a proper CPRMAN clock provider driver
>
> - Stefan moves the SMP startup code for BCM2836 from the interrupt controller
>   driver down to where it belongs in the architecture code, this was requested
>   by Marc Zyngier before comitting any fixes to that code
>
> - Phil provides a fix for a future Raspberry Pi firmware which will make the
>   secondary cores wait for an event and therefore requires the CPU onlining
>   other cores to send such event (along with the appropriate barrier)
>
> - Florian fixes the BRCMSTB UART debug stub to work correctly when using an
>   ARM BE8 kernel since there were some missing register read swapping needed
>

Pulled into next/soc, thanks!

        Arnd
