From: lho@apm.com (Loc Ho)
Date: Wed, 29 Apr 2015 14:56:25 -0700
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <20150429214924.GH5498@pd.tnic>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
 <CAPw-ZTnLR10Zr_p8L3-1nBZ+jKE1HCwERDmO=S5as2GLqime3A@mail.gmail.com>
 <20150429214924.GH5498@pd.tnic>
Message-ID: <CAPw-ZTmoash48S3F8kBxsovD0mEPYBO8=XDaJ2peDu60yaGrZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> > Similar comments for the rest. I would define memory controller
>> > bindings and EDAC driver, then worry about the rest.
>>
>> Okay.. As comment in following emails, I will break up the driver into
>> multiple drivers and focus only on the memory controller driver first.
>
> Please no multiple EDAC drivers. Or do you mean something else here?

We will have the following:

xgene-edac-mc.c
xgene-edac-pmd.c
xgene-edac-l3.c
xgene-edac-soc.c

Or what would you suggest. There are the following HW:

1. 4 DDR controller with one shared top level interrupt, two shared
memory bridges
2. 4 CPU's domain with one shared top level interrupt, shared L2 for
two CPU's, and individual L1
3. 1 L3 with one shared top level interrupt
4. One SoC memory parity block with one shared top level interupt

-Loc
