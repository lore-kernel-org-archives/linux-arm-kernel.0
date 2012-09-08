From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 07 Sep 2012 17:49:37 -0700
Subject: [PATCH 8/9] ARM: msm: Add DT support for 8960
In-Reply-To: <20120907225853.GA21585@codeaurora.org>
References: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
 <1346873339-10927-9-git-send-email-sboyd@codeaurora.org>
 <20120907225853.GA21585@codeaurora.org>
Message-ID: <504A9621.8020301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/12 15:58, David Brown wrote:
> On Wed, Sep 05, 2012 at 12:28:58PM -0700, Stephen Boyd wrote:
>
>> +DT_MACHINE_START(MSM8960_DT, "Qualcomm MSM (Flattened Device Tree)")
> The description string should specify the general name of what this is
> suspporting.  Right now, with these patches, it would list
>
>   Qualcomm MSM (Flattened Device Tree)
>
> twice as the two targets we support (and isn't helpful when you see
> which one it picks).  I'd put the "MSM" name by itself without
> thinking about it too much.  It wasn't that confusing, since there was
> only one at the time.
>
> Perhaps make the 8660 one "Qualcomm MSM8660 (Flattened Device Tree)"
> and the 8960 one "Qualcomm MSM8960 (Flattened Device Tree)"
>
> I realize that the chip numbers are a bit confusing, so probably best
> to pick a canonical name for the description.
>

I think we don't need to do anything. Basically machine name is always
"Qualcomm MSM (Flattened Device Tree)" but then the model name in the
devicetree blob says a more descriptive value "Qualcomm MSM8960 CDP" or
"Qualcomm MSM8660 SURF", etc. All this info is printed in the kernel log
upon boot:

[    0.000000] Machine: Qualcomm MSM (Flattened Device Tree), model: Qualcomm MSM8960 CDP


In fact, it should be possible to put the two dt board files together at
some point if we can somehow drive the map_io routine from devicetree.
In this case we could even have the same machine descriptor used for
both machines.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
