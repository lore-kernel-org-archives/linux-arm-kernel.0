From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 14 Feb 2018 13:39:40 +0530
Subject: [PATCH v3 2/3] arm64: dts: sdm845: Add minimal dts files for
 sdm845 SoC/MTP
In-Reply-To: <CAD=FV=UQ4YD7M8pqReBwE2etUbhuewye0akp0P9SuTnjwLgL4w@mail.gmail.com>
References: <20180212062832.2791-1-rnayak@codeaurora.org>
 <20180212062832.2791-3-rnayak@codeaurora.org>
 <CAD=FV=UQ4YD7M8pqReBwE2etUbhuewye0akp0P9SuTnjwLgL4w@mail.gmail.com>
Message-ID: <2b726c57-3e7c-8406-bb49-3bd56193e009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]..

>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> new file mode 100644
>> index 000000000000..617c7bb25fb1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> It would, of course, be up to Qualcomm.  ...but might I suggest instead:
> 
> // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> The device tree files really don't have any special secret sauce in
> them and IIRC allowing them to have a more permissive MIT license _or_
> a GPL allowed people to run other operating systems on these boards.
> This kind of thing is better to fix now so we don't have to go and get
> everyone's permission later on.

sure, sounds reasonable, but I am told I need to get this reviewed once
by qualcomm legal before we go ahead and use the dual licensing copyright.
I will update based on what I hear.

[]..
> 
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
> 
> IMHO add an extra line to this comment with a description to avoid the
> bike shedding of how we're supposed to do 1-line comments in device
> tree files.  AKA:
> 
> /*
>  * SDM845 MTP board device tree source
>  *
>  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>  */

sure will update.

> 
> 
>> +
>> +/dts-v1/;
>> +
>> +#include "sdm845.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. SDM845 MTP";
>> +       compatible = "qcom,sdm845-mtp";
> 
> For me checkpatch complains about this.  It looks like the file
> "Documentation/devicetree/bindings/arm/qcom.txt" needs to be updated
> with "sdm845".  I don't think that will make checkpatch be quiet
> (since  that file doesn't have a full list of every board), but it
> still should be the correct thing to do.

sure, I missed updating it, will fix.

> 
> 
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> new file mode 100644
>> index 000000000000..55a7e0b454e1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -0,0 +1,275 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> As per above, suggest dual licensed?
> 
> 
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> 
> As per above, suggest adding an extra line to avoid the bikeshed.
> 
> SDM845 SoC device tree source
> 
> 
> Besides those things, everything looks good as far as I can see.  I'm
> not an expert on every one of the devices used in this file, but
> reading through bindings docs and looking at other users of them, it
> looks sane enough.  Thus, with the above nits fixed you can feel free
> to add my Reviewed-by.

Thanks, the only thing I need to wait for before I respin this is to
get a go ahead from legal for the dual licensing copyright header.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
