From: olof@lixom.net (Olof Johansson)
Date: Mon, 10 Sep 2018 10:49:40 -0700
Subject: [RFC, V5,
 2/4] arm_pmu: acpi: Add support for CPU PMU variant detection
In-Reply-To: <1534887901-24734-3-git-send-email-nhillery@codeaurora.org>
References: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
 <1534887901-24734-3-git-send-email-nhillery@codeaurora.org>
Message-ID: <CAOesGMgvi8gTLVej0pR51dpoUMqSwnF1U54kyFnAxf2Ww0wNWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2018 at 2:44 PM, Nathan Hillery <nhillery@codeaurora.org> wrote:
> Device Tree allows CPU PMU variant detection via the PMU device compatible
> property. ACPI does not have an equivalent mechanism, so we introduce
> a probe table to support detection via a device nested inside the CPU
> device in the DSDT:

Isn't it likely that you will need to have some new combination of
features for pretty much every CPU implementation? I.e. would a probe
based on cpuid be a better approach here, and not need ACPI vs DT
tables?


-Olof
