From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 Jan 2018 22:21:02 +0000
Subject: ARM64 SMMU Setup
In-Reply-To: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
References: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
Message-ID: <CAKv+Gu-vwWp_o=XUd17OJ28Brh=Qt_GibpiSMByAXFW07VrxPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2018 at 22:09, Thor Thayer <thor.thayer@linux.intel.com> wrote:
> Hi,
>
> I'm enabling the ARM SMMU-500 on an ARM64 A53. I'm hitting a data abort in
> the probe functions because I'm accessing the registers in EL1 mode.
>

Why do you think the fact that you are running at EL1 is causing the data abort?

> Linux starts in EL2 mode but drops down to EL1 mode by the time it reaches
> the arm-smmu probe function.
>
> Is there something else I need to add to either move the arm-smmu probe
> earlier or remain in EL2 until after the arm-smmu probe?
>

No. I am pretty sure EL2 vs EL1 is not causing your issue. Could you
elaborate on the nature of the exception you are getting?

> A Google search didn't turn up anything so I hoped posting to the list would
> help.
>
> Thanks in advance,
>
> Thor
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
