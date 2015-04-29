From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Apr 2015 17:43:23 -0500
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAPw-ZTmoash48S3F8kBxsovD0mEPYBO8=XDaJ2peDu60yaGrZQ@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
 <CAPw-ZTnLR10Zr_p8L3-1nBZ+jKE1HCwERDmO=S5as2GLqime3A@mail.gmail.com>
 <20150429214924.GH5498@pd.tnic>
 <CAPw-ZTmoash48S3F8kBxsovD0mEPYBO8=XDaJ2peDu60yaGrZQ@mail.gmail.com>
Message-ID: <CAL_JsqL0BMmpVT6hK23ZOhiGRscv1UDYWirA0ik4UZuXf5ku2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 4:56 PM, Loc Ho <lho@apm.com> wrote:
> Hi,
>
>>> > Similar comments for the rest. I would define memory controller
>>> > bindings and EDAC driver, then worry about the rest.
>>>
>>> Okay.. As comment in following emails, I will break up the driver into
>>> multiple drivers and focus only on the memory controller driver first.
>>
>> Please no multiple EDAC drivers. Or do you mean something else here?
>
> We will have the following:
>
> xgene-edac-mc.c
> xgene-edac-pmd.c
> xgene-edac-l3.c
> xgene-edac-soc.c
>
> Or what would you suggest. There are the following HW:
>
> 1. 4 DDR controller with one shared top level interrupt, two shared
> memory bridges

And ECC registers are in the DDR controllers?

I would expect the DT to have 4 DDR controller nodes and probably 2
bridges. The memory bridges have control registers?

> 2. 4 CPU's domain with one shared top level interrupt, shared L2 for
> two CPU's, and individual L1
> 3. 1 L3 with one shared top level interrupt

Presumably the registers for ECC are wired to some other block and not
CPU registers?

> 4. One SoC memory parity block with one shared top level interupt

Shared interrupts are easily supported, but implicit in the DT.
Otherwise, it seems this block is independent from the rest, correct?

Rob
