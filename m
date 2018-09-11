From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 11 Sep 2018 18:15:27 +0100
Subject: [PATCH 11/11] dts: tc2: Update coresight bindings for hardware
 ports
In-Reply-To: <20180911170113.GA27663@e107155-lin>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
 <20180911170113.GA27663@e107155-lin>
Message-ID: <fbde78a0-6487-7bdb-d02b-4fbf556f536e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2018 06:01 PM, Sudeep Holla wrote:
> On Tue, Sep 11, 2018 at 11:17:12AM +0100, Suzuki K Poulose wrote:
>> Switch to the new coresight bindings
>>
> 
> I still see the below warnings:
> 
> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
> 	/replicator/in-ports: graph node has single child node 'port at 0',
> 	#address-cells/#size-cells are not necessary
> vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
> 	/funnel at 20040000/out-ports: graph node has single child node 'port at 0',
> 	#address-cells/#size-cells are not necessary
> 
> I need the below patch to fix them, let me know if it looks OK, I can
> amend and apply.

Thanks for reporting. I purposefully added the "address-cells" and 
followed the format everywhere in the series thinking that, that is
indeed the formal way of doing it, rather than having implicit port
numbers. I can send an updated series fixing it everywhere.

Regards
Suzuki


> 
> Regards,
> Sudeep
> 
> -->8
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index 3a5090616bc6..8b926c30ccd1 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -443,11 +443,7 @@
>   		};
>   
>   		in-ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port at 0 {
> -				reg = <0>;
> +			port {
>   				replicator_in_port0: endpoint {
>   					remote-endpoint = <&funnel_out_port0>;
>   				};
> @@ -462,11 +458,7 @@
>   		clocks = <&oscclk6a>;
>   		clock-names = "apb_pclk";
>   		out-ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port at 0 {
> -				reg = <0>;
> +			port {
>   				funnel_out_port0: endpoint {
>   					remote-endpoint =
>   						<&replicator_in_port0>;
> 
