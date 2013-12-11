From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 11 Dec 2013 18:50:42 +0900
Subject: [PATCH 00/10] sh-pfc: Fix GPIO to IRQ mapping
In-Reply-To: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CANqRtoRR+rz+VYr-SrZHGg9fcy4exC0L6m_=5HWcRqLBbxxcig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 12:26 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> This patch set fixes conversion from a GPIO number to an IRQ number in the
> sh-pfc driver in the device tree case.
>
> Patches 01/10 to 05/10 clean up the driver to prepare it for the core fix in
> patch 06/10. As explained in patch 06/10 commit message, on non-DT platforms
> IRQ controllers associated with the GPIOs have a fixed IRQ base value known at
> compile time. The sh-pfc driver translates GPIO number to IRQ numbers using a
> hardcoded table. This mechanism breaks on DT platforms, as the IRQ base values
> are dynamic in that case.
>
> The patch set fixes this by specifying IRQs associated with GPIOs in IRQ
> resources, populated automatically from the device tree. When IRQ resources
> are specified the driver requires one IRQ resource per GPIO able to generate
> an interrupt, and uses the translation table to compute the IRQ resource
> offset instead of the IRQ number.
>
> Patches 07/10 to 09/10 then add PFC interrupts in DT for the SH73A0, R8A73A4
> and R9A7740 SoCs. The only missing platform here is SH7372 due to its very
> uncomplete DT support. All other Renesas ARM platforms use a standaline GPIO
> driver and are thus not affected.
>
> Patch 10/10 finally adds a gpio-keys device to the Armadillo board DTS,
> allowing the whole patch set to the tested.
>
> The sh-pfc changes need to be merged first. Linus, could you please provide a
> stable branch with the first 6 patches when you will apply them to your tree ?
>
> Laurent Pinchart (10):
>   sh-pfc: Turn unsigned indices into unsigned int
>   sh-pfc: Terminate gpios array by -1
>   sh-pfc: sh73a0: Add missing IRQ15
>   sh-pfc: sh73a0: Sort IRQ entries by IRQ number
>   sh-pfc: Rename sh_pfc window field to windows
>   sh-pfc: Support GPIO to IRQ mapping specified IRQ resources
>   ARM: shmobile: r8a73a4: Specify PFC interrupts in DT
>   ARM: shmobile: r8a7740: Specify PFC interrupts in DT
>   ARM: shmobile: sh73a0: Specify PFC interrupts in DT
>   ARM: shmobile: armadillo: dts: Add gpio-keys device

Looking great, nice to see that this is getting resolved! For the entire series:

Acked-by: Magnus Damm <damm@opensource.se>
