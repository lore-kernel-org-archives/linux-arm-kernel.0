From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Jul 2018 17:13:56 -0600
Subject: [PATCH v3 8/9] coresight: Cleanup coresight DT bindings
In-Reply-To: <1532686537-12380-9-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <1532686537-12380-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180730231356.GA6353@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 11:15:36AM +0100, Suzuki K Poulose wrote:
> The coresight drivers relied on default bindings for graph
> in DT, while reusing the "reg" field of the "ports" to indicate
> the actual hardware port number for the connections. This can
> cause duplicate ports with same addresses, but different
> direction. However, with the rules getting stricter for the
> address mismatch with the label, it is no longer possible to use
> the port address field for the hardware port number.
> 
> This patch introduces new DT binding rules for coresight
> components, based on the same generic DT graph bindings, but
> avoiding the address duplication.
> 
> - All output ports must be specified under a child node with
>   name "out-ports".
> - All input ports must be specified under a childe node with
>   name "in-ports".
> - Port address should match the hardware port number.
> 
> The support for legacy bindings is retained, with a warning.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 95 ++++++++++++---------

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/hwtracing/coresight/of_coresight.c         | 98 +++++++++++++++++++---
>  2 files changed, 143 insertions(+), 50 deletions(-)
