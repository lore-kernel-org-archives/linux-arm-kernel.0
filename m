From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 20 Jun 2018 10:53:26 +0100
Subject: [PATCH 00/20] coresight: Update device tree bindings
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <7b03e604-3792-7846-56dc-d3feae5410d8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/18 22:43, Suzuki K Poulose wrote:
> Coresight uses DT graph bindings to describe the connections of the
> components. However we have some undocumented usage of the bindings
> to describe some of the properties of the connections.
> 
> The coresight driver needs to know the hardware ports invovled
> in the connection and the direction of data flow to effectively
> manage the trace sessions. So far we have relied on the "port"
> address (as described by the generic graph bindings) to represent
> the hardware port of the component for a connection.
> 

...

> There were three options considered for the hardware port number scheme:
> 


...

>   3) Use explicit properties (implemented in the series) for the hardware
>      port id and direction. We define a new property "coresight,hwid" for
>      each endpoint in coresight devices to specify the hardware port number
>      explicitly. Also use a separate property "direction" to specify the
>      direction of the data flow.
> 
> 	e.g,
> 
> 	port at 0{
> 		reg = <0>;
> 		endpoint {
> 			direction = <1>;	// Output
> 			coresight,hwid = <0>;	// Port # 0
> 		}
> 	};
> 
> 	port at 1{
> 		reg = <1>;
> 		endpoint {
> 			direction = <0>;	// Input
> 			coresight,hwid = <0>;	// Port # 0
> 		};
> 	};
> 
>      Pros:
>         - The bindings are formal and reader friendly, and less prone to errors.
>      Cons:
>         - Backward compatibility is lost.
> 
> 
> This series implements Option (3) listed above and falls back to the old
> bindings if the new bindings are not available. This allows the systems
> with old bindings work with the new driver. The driver now issues a warning
> (once) when it encounters the old bindings.

  ....

>    dts: juno: Update coresight bindings for hw port
>    dts: hisilicon: Update coresight bindings for hw ports
>    dts: spreadtrum: Update coresight bindings for hw ports
>    dts: qcom: Update coresight bindings for hw ports
>    dts: arm: hisilicon: Update coresight bindings for hardware port
>    dts: arm: imx7{d,s}: Update coresight binding for hardware ports
>    dts: arm: omap: Update coresight bindings for hardware ports
>    dts: arm: qcom: Update coresight bindings for hardware ports
>    dts: sama5d2: Update coresight bindings for hardware ports
>    dts: ste-dbx5x0: Update coresight bindings for hardware port
>    dts: tc2: Update coresight bindings for hardware ports
> 

All,

Pleas hold on with applying the DTS changes listed above. There are
still some on going discussions on the bindings and we are yet to
come to a conclusion [0]. And there are high chances that these might
change. Sorry for the inconvenience.

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582269.html

Kind regards
Suzuki
