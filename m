From: robh@kernel.org (Rob Herring)
Date: Tue, 6 Feb 2018 14:36:10 -0600
Subject: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
In-Reply-To: <20180126221808.GE28313@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
Message-ID: <CAL_JsqKEgYLMEbSj37rNV-Zu+vd7pEPQJm4pD3zP8atZBR03aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 4:18 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/25, Rajendra Nayak wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> new file mode 100644
>> index 000000000000..b97f99e6f4b4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> @@ -0,0 +1,32 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +&tlmm {
>
> I'm not the maintainer, but I find this approach to the pins
> really annoying. I have to flip to another file to figure out how
> a board has configured the pins. And we may bring in a bunch of
> settings that we don't ever use on some board too. Why can't we
> put the settings in the board file directly?

FYI, there's a pending dtc change to allow deleting unreferenced nodes
which can solve the bloat problem.

Rob
