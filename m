From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:18:17 -0600
Subject: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
In-Reply-To: <b0d8147a-46e1-0787-ae37-9c1ef957d190@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
 <20171220032614.GQ19815@vireshk-i7>
 <b0d8147a-46e1-0787-ae37-9c1ef957d190@codeaurora.org>
Message-ID: <20171220211817.mpkkj747blr4qkqm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 11:55:33AM +0530, Sricharan R wrote:
> Hi Viresh,
> 
> On 12/20/2017 8:56 AM, Viresh Kumar wrote:
> > On 19-12-17, 21:25, Sricharan R wrote:
> >> +	cpu at 0 {
> >> +		compatible = "qcom,krait";
> >> +		enable-method = "qcom,kpss-acc-v1";
> >> +		device_type = "cpu";
> >> +		reg = <0>;
> >> +		qcom,acc = <&acc0>;
> >> +		qcom,saw = <&saw0>;
> >> +		clocks = <&kraitcc 0>;
> >> +		clock-names = "cpu";
> >> +		cpu-supply = <&smb208_s2a>;
> >> +		operating-points-v2 = <&cpu_opp_table>;
> >> +	};
> >> +
> >> +	qcom,pvs {
> >> +		qcom,pvs-format-a;
> >> +	};
> > 
> > Not sure what Rob is going to say on that :)
> > 
> 
>  Yes. Would be good to know the best way.

Seems like this should be a property of an efuse node either implied by 
the compatible or a separate property. What determines format A vs. B?

Rob
