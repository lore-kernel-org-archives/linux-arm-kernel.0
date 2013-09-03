From: Alison_Chaiken@mentor.com (Chaiken, Alison)
Date: Tue, 3 Sep 2013 16:01:27 +0000
Subject: [PATCH 1/2] ARM: i.MX6: dts: change iomuxc pinctrl config to
 match Rev. 1 IMX6DQRM
In-Reply-To: <52241BB3.5030909@freescale.com>
References: <521C40D9.3070802@freescale.com>
 <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
 <1377659855-9573-2-git-send-email-alison_chaiken@mentor.com>,
 <52241BB3.5030909@freescale.com>
Message-ID: <60BA5429A0E1584BA3633194F6F993B502F2D8D2@NA-MBX-02.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I wrote:
>> @@ -759,23 +759,23 @@
>>                               gpmi-nand {
>>                                       pinctrl_gpmi_nand_1: gpmi-nand-1 {
>>                                               fsl,pins = <
>> -                                                     MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
>> -                                                     MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
[ . . . ]
>>                                       };
>>                               };

Huang Shijie [b32955 at freescale.com] responds:
>I tested this patch with the imx6q-ard board and imx6dl-ard board.
>For the gpmi nand test result:
>[1] imx6q-ard: We can pass the bonie++ stress test with the imx6q-ard board.
>[2] imx6dl-ard: But we fails to read the nand ID with the imx6dl-ard board.
>In other word, this gpmi can _not_ works with this patch.

Huang, I appreciate your speedy testing and sharing of results.   While I carefully and lengthily RTFM to create this patch, we can agree that making the hardware work well is the final goal!   We have tested the patch I sent on our hardware with our tests, but certainly any patch that renders some features of some boards inoperable is unacceptable.

The patch we are discussing is about 670 lines, and the NAND part is about 60.   What is your advice regarding the remaining ~600 lines?  

Best wishes,
Alison Chaiken
Mentor Embedded Software Division
Fremont, CA, USA
