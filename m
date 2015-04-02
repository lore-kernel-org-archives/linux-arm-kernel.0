From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 2 Apr 2015 14:25:17 -0500
Subject: [GIT PULL] qcom SoC changes for v4.1
In-Reply-To: <CAP71WjzKSRRSVLcwpZTaQOYp2uziP7=J=E=3bHAzCjui-ZqbYQ@mail.gmail.com>
References: <alpine.DEB.2.02.1503161601450.30317@galak-ubuntu.qualcomm.com>
 <CAP71WjzKSRRSVLcwpZTaQOYp2uziP7=J=E=3bHAzCjui-ZqbYQ@mail.gmail.com>
Message-ID: <42F2C5A0-5231-4D4B-95EE-7BC173A14768@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Apr 2, 2015, at 3:37 AM, Nicolas Dechesne <nicolas.dechesne@linaro.org> wrote:

> Andy, Kumar,
> 
> On Mon, Mar 16, 2015 at 10:03 PM, Kumar Gala <galak@codeaurora.org> wrote:
>> Andy Gross (1):
>>      soc: qcom: gsbi: Add support for ADM CRCI muxing
> 
> this commit seems to break the boot on IFC6410, it was initially
> reported on kernelci.org, see report and bootlog [1].
> 
> running git bisect led me to:
> 
> e5fdad68d47ed344832b7ca4e18b2e9708d8141e is the first bad commit
> commit e5fdad68d47ed344832b7ca4e18b2e9708d8141e
> Author: Andy Gross <agross@codeaurora.org>
> Date:   Mon Feb 9 16:01:06 2015 -0600
> 
>    soc: qcom: gsbi: Add support for ADM CRCI muxing
> 
>    This patch adds automatic configuration for the ADM CRCI muxing required to
>    support DMA operations for GSBI clients.  The GSBI mode and
> instance determine
>    the correct TCSR ADM CRCI MUX value that must be programmed so that the DMA
>    works properly.
> 
>    Signed-off-by: Andy Gross <agross@codeaurora.org>
>    Signed-off-by: Kumar Gala <galak@codeaurora.org>
> 
> 
> [1] http://kernelci.org/boot/all/job/arm-soc/kernel/v4.0-rc4-354-ga0690e6586df/

I think we need to associated DT updates.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
