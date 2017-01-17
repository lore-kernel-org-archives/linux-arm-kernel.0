From: Mike.Leach@arm.com (Mike Leach)
Date: Tue, 17 Jan 2017 14:52:31 +0000
Subject: [PATCH v4 4/4] arm64: dts: juno: add missing CoreSight STM
 component
In-Reply-To: <6473418b-95d5-5be3-47fd-4c554f353923@arm.com>
References: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
 <1484655313-9025-5-git-send-email-sudeep.holla@arm.com>
 <5c742b98-0707-67fd-d8a1-467f34d99cdb@arm.com>
 <6473418b-95d5-5be3-47fd-4c554f353923@arm.com>
Message-ID: <DB6PR0802MB2198D30880E268077202AAD88C7C0@DB6PR0802MB2198.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----------------------------------------------------------------
Mike Leach                           +44 (0)1254 893911 (Direct)
Principal Engineer                   +44 (0)1254 893900 (Main)
Arm Blackburn Design Centre          +44 (0)1254 893901 (Fax)
Belthorn House
Walker Rd                            mailto:mike.leach at arm.com
Guide
Blackburn
BB1 2QE
----------------------------------------------------------------


> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: 17 January 2017 14:01
> To: Suzuki Poulose; linux-arm-kernel at lists.infradead.org; Mike Leach; Mike
> Leach
> Cc: Sudeep Holla; Mathieu Poirier; Lorenzo Pieralisi; coresight at lists.linaro.org;
> Liviu Dudau; devicetree at vger.kernel.org; Olof Johansson
> Subject: Re: [PATCH v4 4/4] arm64: dts: juno: add missing CoreSight STM
> component
>
>
>
> On 17/01/17 13:39, Suzuki K Poulose wrote:
> > On 17/01/17 12:15, Sudeep Holla wrote:
> >> From: Mike Leach <mike.leach@linaro.org>
> >>
> >> This patch adds the missing CoreSight STM component definition to the
> >> device tree of all the juno variants(r0,r1,r2)
> >>
> >> STM component is connected to different funnels depending on Juno
> >> platform variant.
> >>
> >> Reviewed-and-Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> >> [sudeep.holla at arm.com: minor changelog update and reorganising the STM
> >>     node back into juno-base.dtsi to avoid duplication]
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>  arch/arm64/boot/dts/arm/juno-base.dtsi | 15 +++++++++++++++
> >>  arch/arm64/boot/dts/arm/juno-r1.dts    |  4 ++++
> >>  arch/arm64/boot/dts/arm/juno-r2.dts    |  4 ++++
> >>  arch/arm64/boot/dts/arm/juno.dts       | 16 ++++++++++++++++
> >>  4 files changed, 39 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi
> >> b/arch/arm64/boot/dts/arm/juno-base.dtsi
> >> index faedf357db3b..58c1773c3aa4 100644
> >> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> >> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> >> @@ -185,6 +185,21 @@
> >>          };
> >>      };
> >>
> >> +    stm at 20100000 {
> >> +        compatible = "arm,coresight-stm", "arm,primecell";
> >> +        reg = <0 0x20100000 0 0x1000>,
> >> +              <0 0x28000000 0 0x180000>;
> >
> > The size of the stimulus base is 16MB (as per TRM), implies => 0x1000000.
> >
>
> Fixed locally.
>
> Mike,
>
> Can you confirm ? I know TRM had some issues with size of other
> coresight components.
>
Checked both Juno and STM arch manuals - these are in agreement that the STM memory stimulus area is 16MB in size.
Thus for Juno specifically with all masters seeing the same area @ base 0x28000000, <0 0x28000000 0 0x1000000 >  would be the correct description.

Mike

> > with that fixed :
> >
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
>
> Thanks.
>
> --
> Regards,
> Sudeep
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
