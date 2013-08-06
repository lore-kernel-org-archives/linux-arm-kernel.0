From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Tue, 06 Aug 2013 11:28:01 -0700
Subject: [PATCH 1/2] ARM: msm: Add support for MSM8974 Dragonboard
In-Reply-To: <76477E73-B68A-4025-875E-4BA30F5E175A@codeaurora.org>
References: <1375743779-24993-1-git-send-email-rvaswani@codeaurora.org>
 <76477E73-B68A-4025-875E-4BA30F5E175A@codeaurora.org>
Message-ID: <52014031.7000202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/6/2013 8:47 AM, Kumar Gala wrote:
> On Aug 5, 2013, at 6:02 PM, Rohit Vaswani wrote:
>
>> This patch adds basic board support for MSM8974 Dragonboard
>> which belongs to the Snapdragon 800 family.
>> For now, just support a basic machine with device tree.
> I think the board is APQ8074 and not MSM8974.
>
>> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
>> ---
>> arch/arm/boot/dts/Makefile        |  3 ++-
>> arch/arm/boot/dts/msm8974-db.dts  | 26 ++++++++++++++++++++++++++
>> arch/arm/mach-msm/Kconfig         | 21 ++++++++++++++++++---
>> arch/arm/mach-msm/Makefile        |  1 +
>> arch/arm/mach-msm/board-dt-8974.c | 23 +++++++++++++++++++++++
>> 5 files changed, 70 insertions(+), 4 deletions(-)
>> create mode 100644 arch/arm/boot/dts/msm8974-db.dts
>> create mode 100644 arch/arm/mach-msm/board-dt-8974.c
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 641b3c9a..62cea36 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -97,7 +97,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
>> 	kirkwood-openblocks_a6.dtb
>> dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
>> dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>> -	msm8960-cdp.dtb
>> +	msm8960-cdp.dtb \
>> +	msm8974-db.dtb
>> dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>> 	armada-370-mirabox.dtb \
>> 	armada-370-rd.dtb \
>> diff --git a/arch/arm/boot/dts/msm8974-db.dts b/arch/arm/boot/dts/msm8974-db.dts
>> new file mode 100644
>> index 0000000..badfc61
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/msm8974-db.dts
>> @@ -0,0 +1,26 @@
>> +/dts-v1/;
>> +
>> +/include/ "skeleton.dtsi"
> We should change msm8974.dts to msm8974.dtsi and include it for the board.

We can do that once we have something separate/new to add to the dtsi file.

<snip>

Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
