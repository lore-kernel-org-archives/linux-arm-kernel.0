From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 17 Sep 2014 08:37:30 -0700
Subject: [RFC PATCH] dt:numa: adding numa node mapping for memory nodes.
In-Reply-To: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <A4205FCA-D4DE-48A4-B19F-58400A3FBF5C@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 17, 2014, at 1:56 AM, Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com> wrote:

> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> This patch adds property "nid" to memory node to provide the memory range to
> numa node id mapping.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> ?

Adding the PPC guys as they?ve been doing NUMA on IBM Power Servers for years with OF/DT.  So we should really try and follow what they?ve done.

> Documentation/devicetree/bindings/numa.txt | 58 ++++++++++++++++++++++++++++++
> 1 file changed, 58 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/numa.txt
> 
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> new file mode 100644
> index 0000000..c4a94f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -0,0 +1,58 @@
> +======================================================
> +numa id binding description
> +======================================================
> +
> +======================================================
> +1 - Introduction
> +======================================================
> +The device node  property "nid(numa node id)" can be added to memory
> +device node to map the range of memory addresses as defined in property "reg".
> +The property "nid" maps the memory range to the numa node id, which is used to
> +find the local and remory pages on numa aware systems.
> +
> +======================================================
> +2 - nid property
> +======================================================
> +Numa node id, "nid" is required property of memory device node for 
> +numa enabled platforms.
> +
> +|------------------------------------------------------|
> +|Property Type  | Usage | Value Type | Definition      |
> +|------------------------------------------------------|
> +|  nid          |  R    |    <u32>   | Numa Node id    |
> +|               |       |            | for this memory |
> +|------------------------------------------------------|
> +
> +========================================================
> +4 - Example memory nodes with numa node id mapping
> +========================================================
> +
> +Example 1 (2 memory nodes, each mapped to a numa node.):
> +
> +	memory at 00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> +		nid = <0x0>;
> +	};
> +
> +	memory at 10000000000 {
> +		device_type = "memory";
> +		reg = <0x100 0x00000000 0x0 0x80000000>;
> +		nid = <0x1>;
> +	};
> +
> +Example 2 (multiple memory ranges in each memory node and mapped to numa node):
> +
> +	memory at 00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>,
> +		      <0x0 0x80000000 0x0 0x80000000>;
> +		nid = <0x0>;
> +	};
> +
> +	memory at 10000000000 {
> +		device_type = "memory";
> +		reg = <0x100 0x00000000 0x0 0x80000000>,
> +		      <0x100 0x80000000 0x0 0x80000000>;
> +		nid = <0x1>;
> +	};
> -- 
> 1.8.1.4
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
