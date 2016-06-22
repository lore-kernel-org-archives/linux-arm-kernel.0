From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 21 Jun 2016 21:49:16 -0700
Subject: [PATCH v2 1/8] arm64: dts: db820c: add basic board support
In-Reply-To: <1466529769-2674-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1466529769-2674-2-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160622044916.GF1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 21 Jun 10:22 PDT 2016, Srinivas Kandagatla wrote:

[..]
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
[..]
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. DB820c";
> +	compatible = "qcom,apq8096-sbc";

I'm still not buying the concept of this being the one and only
single-board-computer.

If this compatible fully and exclusively identifies this particular
board then dtbTool should be updated to follow the product name
"qcom,apq8096-db820c". If on the other hand this identifies a class of
single-board-computers, then the compatible should list both
"qcom,apq8096-dtb820c" and "qcom,apq8096-sbc".



Further more, the ePAPR defines this property as:
"Specifies a list of platform architectures with which this platform is
compatible. This property can be used by operating systems in selecting
platform specific code."

So I think we should follow the common pattern of having the least
significant entry being "qcom,apq8096".

> +};

Regards,
Bjorn
