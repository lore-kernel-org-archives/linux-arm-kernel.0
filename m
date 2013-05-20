From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 20 May 2013 05:01:47 +0000
Subject: [PATCH v3 4/4] ARM: dts: add initial MVF600 Tower board dts
 support
In-Reply-To: <20130519152932.GA24301@S2101-09.ap.freescale.net>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <1368684648-20826-5-git-send-email-b35083@freescale.com>
 <20130519152932.GA24301@S2101-09.ap.freescale.net>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CB26E@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +
>> +	sound {
>> +		compatible = "fsl,mvf600-audio-sgtl5000";
>> +		model = "mvf600-sgtl5000";
>> +		sai-controller = <&sai2>;
>> +		audio-codec = <&codec>;
>> +		audio-routing =
>> +			"MIC_IN", "Mic Jack",
>> +			"Mic Jack", "Mic Bias",
>> +			"Headphone Jack", "HP_OUT";
>> +	};
>
>Has this been tested against mainline kernel?  If not, please remove it.
>
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c0_1>;
>> +
>> +	codec: sgtl5000 at 0a {
>> +		compatible = "fsl,sgtl5000";
>> +		reg = <0x0a>;
>> +		clocks = <&clks MVF600_CLK_SAI2>;
>
>The sgtl5000 uses SAI2 clock?
[Lu Jingchang-B35083] 
  Yes, the sgtl5000 uses the SAI2 clock on MVF600 Tower board. Thanks!
>
>> +	};
>> +};
>
>Is i2c-imx driver working for mvf600 right now?
>
>
>Do we have a QuadSPI driver on mainline kernel?  Please only add it when
>it's been tested against mainline kernel.
[Lu Jingchang-B35083] 
 Sound, I2C, QuadSPI and SAI added in the initial dts have been test locally on the mainline kernel, and the patches will be sent to maillist later. Thanks!
