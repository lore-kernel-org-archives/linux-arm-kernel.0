From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Dec 2017 21:17:04 -0800
Subject: [PATCH v2 05/10] arm64: dts: qcom: apq8016-sbc: sort nodes
 alphabetically
In-Reply-To: <20171207151942.5805-6-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
 <20171207151942.5805-6-damien.riegel@savoirfairelinux.com>
Message-ID: <20171216051704.GB4281@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 07 Dec 07:19 PST 2017, Damien Riegel wrote:

> Also, it was using whitespaces for indentation on some lines, fix that
> while moving it.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Rather than extending single nodes like this I would prefer that we
bring in the associated pmic node, by this we avoid just having a huge
flat list of nodes. I.e. that we make this:

&pm8916_1 {
	codec at f000 {
		status = "okay";
		clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
		clock-names = "mclk";
		qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
		qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
	};
};

Regards,
Bjorn
