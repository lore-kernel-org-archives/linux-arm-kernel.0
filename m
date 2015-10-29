From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Oct 2015 23:22:29 -0500
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <5630C143.5080103@free.fr>
References: <5630C143.5080103@free.fr>
Message-ID: <CAL_Jsq+M+HUevNkaLrE6fvyxEbsBDYdg7odNEzw0UWfUrHwMMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 7:36 AM, Mason <slash.tmp@free.fr> wrote:
> Hello,
>
> I'm working on a dual-core SoC (Cortex-A9 MPCore) with Linux running
> as the non-secure OS. The secure OS implements some of the APIs used
> in OMAP2 via SMC.
>
> To start the second core, I used to define .smp in my DT_MACHINE_START
> definition, but Arnd wrote: "There are other ways to do [.smp and .restart]
> too, see CPU_METHOD_OF_DECLARE() and register_restart_handler()."
>
> Is CPU_METHOD_OF_DECLARE() the way to go?

Yes.

> Is it "compatible" with executing smc to ask the secure OS to do whatever
> is needed to start the second core? (I don't understand why starting cores
> is secure OS responsibility.)

Yes, that is what PSCI does. In your case, these are not PSCI calls though?

>
> I've located three relevant secure OS services:
> get_aux_core_boot
> set_aux_core_boot0
> set_aux_core_boot_addr
>
> I'm looking for guidance. What mach-* should I take as a reference to
> implement "second core startup from non-secure OS"?

I don't think there is a mach example that matches. PSCI would be the
closest example. But doing a smc call versus writing some registers
are not all that different and there are numerous examples of the
latter.

Rob
