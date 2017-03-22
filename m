From: sven.eckelmann@openmesh.com (Sven Eckelmann)
Date: Wed, 22 Mar 2017 15:10:49 +0100
Subject: [15/17] qcom: ipq4019: add cpu operating points for cpufreq
 support
In-Reply-To: <1458770712-10880-16-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-16-git-send-email-mmcclint@codeaurora.org>
Message-ID: <40277521.UIyJVnYny8@bentobox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mittwoch, 23. M?rz 2016 17:05:10 CET Matthew McClintock wrote:
> This adds some operating points for cpu frequeny scaling
> 
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
[...]

I saw that you've created a new version of the patch and it was added to
different staging/testing [1] trees.

But I find it rather odd that Codeaurora uses different settings [3]. Here for 
easier comparison:

setting     | QSDK 1.1.3     | proposed patch
---------------------------------------------
clk-latency |         100000 |    256000
opp0        |     48000(000) |  48000000
opp1        |    200000(000) | 200000000
opp2        |    500000(000) | 500000000
opp3        |    710000(000) | 666000000

It looks to me like clk-latency and the opp3 (maximum frequency) are 
different. Is the reason for this difference known?

I've just noticed it because I got an DTB from an ODM which had even
716000(000) set for opp3.

Kind regards,
	Sven

[1] https://git.lede-project.org/?p=lede/blogic/staging.git;a=blob;f=target/linux/ipq806x/patches-4.9/0017-qcom-ipq4019-add-cpu-operating-points-for-cpufreq-su.patch;h=7cbd6a4551bfd968d013164f76897c603f4ae2ff;hb=627e9c2c36839634d987535658a287843a8a9fd6
[2] https://github.com/chunkeey/LEDE-IPQ40XX/blob/a04cf208fe317074502f7ea81dafa828c89b74bb/target/linux/ipq40xx/patches-4.9/120-qcom-ipq4019-add-cpu-operating-points-for-cpufreq-su.patch
[3] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-msm/tree/arch/arm/boot/dts/qcom-ipq40xx.dtsi?h=release/date_r1&id=461894f071b168c963795ebfa15d3458b102730a#n768
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/9327cde0/attachment.sig>
