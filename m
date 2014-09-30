From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 30 Sep 2014 08:49:52 -0500
Subject: [RFC 0/7] Qualcomm SMEM, SMD, RPM and regulators
In-Reply-To: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <E6EEBBAE-C710-4280-824D-CC5D54CB2551@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 29, 2014, at 7:34 PM, Bjorn Andersson <Bjorn.Andersson@sonymobile.com> wrote:

> All Qualcomm platforms implements a shared heap among the processors in the
> SoC, used for sharing data with other parts of the system.
> 
> One consumer of items from this heap is the "Shared Memory Driver", a ring
> buffer based point-to-point communication mechanism used to send either stream
> or packet based data to remote processors.
> 
> Starting with 8x74 this system is used to talk to the Resource Power Manager
> (RPM), a power efficient "coprocessor" with responsibility of aggregate votes
> from the various systems in the SoC related to regulators, clocks and bus
> frequencies.
> 
> The PMIC regulators and root clocks in these platforms are only accessible via
> the RPM, so to get access to these we need the full chain of smem, smd, rpm and
> a regulator driver implemented. And that is exactly what this series provides.
> 
> 
> A key outstanding question is where in the tree we should put the
> implementation, for now I dropped them in drivers/soc/qcom but that's only
> because I don't know where to put it otherwise. I have not found any equivalent
> of the SMEM driver, SMD resembles mailbox and rpmsg - but comments in that
> patch on why it's neither.
> 
> RPM is a mfd and regulator is a regulator :)

I still don?t see why RPM support for either A-family or B-family should exist in MFD vis drivers/soc/qcom.  What benefit is there in putting this in MFD?

I think both A and B-family support should be in drivers/soc/qcom for the current time being until we determine there is some framework that makes more sense in the future.  I almost see RPM more like a bus controller than anything else.  Something like an I2C bus controller that than has some set of devices off of that bus.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
