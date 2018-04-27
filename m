From: kieran.bingham+renesas@ideasonboard.com (Kieran Bingham)
Date: Fri, 27 Apr 2018 17:22:06 +0100
Subject: [PATCH 15/17] arm64: dts: r8a77965-salvator-x: Enable HDMI output
In-Reply-To: <2345148.J1marZVneP@avalon>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-16-kieran.bingham+renesas@ideasonboard.com>
 <2345148.J1marZVneP@avalon>
Message-ID: <5af7b6a6-8a40-880d-3346-8c90bd700957@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 26/04/18 22:21, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 26 April 2018 19:53:44 EEST Kieran Bingham wrote:
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> Enable the HDMI encoder for the M3N Salvator-X board and hook it up to
>> the HDMI connector.
>>
>> Based on a similar patches of the the Salvator-X board
>> on the R8A7796 SoC device tree
>> by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, collected.

> 
> How about adding the VGA output too ? I think you can add both VGA and HDMI in 
> a single patch that enables display in one go for the board. Same comment for 
> the Salvator-XS.

I believe the VGA output is handled by the salvator-common.dtsi, and thus
doesn't need to be included in this patch.

> 
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  .../boot/dts/renesas/r8a77965-salvator-x.dts    | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
>> b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts index
>> a2b8fb20fef8..11e8d43e9e11 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
>> @@ -31,3 +31,20 @@
>>  	clock-names = "du.0", "du.1", "du.3", "lvds.0",
>>  		      "dclkin.0", "dclkin.1", "dclkin.3";
>>  };
>> +
>> +&hdmi0 {
>> +	status = "okay";
>> +
>> +	ports {
>> +		port at 1 {
>> +			reg = <1>;
>> +			rcar_dw_hdmi0_out: endpoint {
>> +				remote-endpoint = <&hdmi0_con>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&hdmi0_con {
>> +	remote-endpoint = <&rcar_dw_hdmi0_out>;
>> +};
> 
