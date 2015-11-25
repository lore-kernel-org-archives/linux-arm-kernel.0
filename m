From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 12:22:24 +0100
Subject: [RFC PATCH 00/10] Support for Cortex-M Prototyping System
In-Reply-To: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
References: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20614077.l46PyO8gV6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 10:33:31 Vladimir Murzin wrote:
> Hi,
> 
> This patch series provide the basic support for running ucLinux on V2M-MPS2
> platform.
> 
> With these patches applied ucLinux can be run on both HW and FVP models
> with Cortex-M3/M4/M7 configurations.
> 
> Board description:
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.100112_0100_03_en/arm_versatile_express_cortex_m_prototyping_system_(v2m_mps2)_technical_reference_manual_100112_0100_03_en.pdf
> 
> Application notes (cover Cortex-M3/M4/M7):
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.dai0385a/DAI0385A_cortex_m3_on_v2m_mps2.pdf
> http://infocenter.arm.com/help/topic/com.arm.doc.dai0386a/DAI0386A_cortex_m4_on_v2m_mps2.pdf
> http://infocenter.arm.com/help/topic/com.arm.doc.dai0399a/DAI0399A_cortex_m7_on_v2m_mps2.pdf
> http://infocenter.arm.com/help/topic/com.arm.doc.dai0400a/DAI0400A_cortex_m7_on_v2m_mps2.pdf
> 
> Cortex-M System Design Kit (referenced as CMDK from documents above):
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0479c/DDI0479C_cortex_m_system_design_kit_r1p0_trm.pdf
> 
> I'd be happy to hear any feedback/comments on this series!

Looks pretty good overall, I didn't have any specific concerns.

> Remain questions:
> 
>  - Application notes 399/400 have PSRAM located at address different to what
>    we have for AN385/AN386, so I'm wondering what is the best practice to handle
>    CONFIG_DRAM_BASE? Different defconfig or there is better place?

I would not want to add more than one defconfig for a relatively simple
platform. Most actual users would have to modify their config anyway, so
I think it's best to just have one config file for the most common machine
here and let users change the dram base if they have the other one.

We can also look at using the Kconfig fragments infrastructure more here.
 
>  - I'm not sure about naming of dts files: Application Notes (mps2-an*) vs Cortex-M (mps2-cm*);
>    any preference?

I don't mind either way.

	Arnd
