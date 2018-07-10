From: collinsd@codeaurora.org (David Collins)
Date: Tue, 10 Jul 2018 15:32:11 -0700
Subject: [PATCH 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB
 regulators
In-Reply-To: <20180710220202.116404-3-dianders@chromium.org>
References: <20180710220202.116404-1-dianders@chromium.org>
 <20180710220202.116404-3-dianders@chromium.org>
Message-ID: <0d334051-2ba5-075d-df8c-affe3e617e8d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 07/10/2018 03:02 PM, Douglas Anderson wrote:
...
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +		vdd-s11-supply = <&vph_pwr>;
> +		vdd-s12-supply = <&vph_pwr>;
> +		vdd-s13-supply = <&vph_pwr>;
> +		vdd-l1-l27-supply = <&vreg_s7a_1p025>;
> +		vdd-l2-l8-l17-supply = <&vreg_s3a_1p35>;
> +		vdd-l3-l11-supply = <&vreg_s7a_1p025>;
> +		vdd-l4-l5-supply = <&vreg_s7a_1p025>;
> +		vdd-l6-supply = <&vph_pwr>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
> +		vdd-l9-supply = <&vreg_bob>;
> +		vdd-l10-l23-l25-supply = <&vreg_bob>;
> +		vdd-l13-l19-l21-supply = <&vreg_bob>;
> +		vdd-l16-l28-supply = <&vreg_bob>;
> +		vdd-l18-l22-supply = <&vreg_bob>;
> +		vdd-l20-l24-supply = <&vreg_bob>;
> +		vdd-l26-supply = <&vreg_s3a_1p35>;
> +		vin-lvs-1-2-supply = <&vreg_s4a_1p8>;

I would suggest not specifying any of these regulator parent supplies in
device tree.  RPMh will be enforcing all regulator parent-child
dependencies.  Therefore, handling the dependencies in Linux is redundant.
 It will result in additional RPMh requests as well as more time spent in
regulator framework calls.  Overall, it will lead to slightly lower
performance.  Note that while specifying the parent supplies results in
less efficient runtime behavior, it is not technically wrong so you could
keep them in place if you prefer.

Take care,
David
