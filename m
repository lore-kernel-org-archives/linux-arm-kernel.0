From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Sep 2014 12:03:21 -0700
Subject: [RFC 1/7] soc: qcom: Add device tree binding for SMEM
In-Reply-To: <1412037291-16880-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <542AFE79.6030304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/14 17:34, Bjorn Andersson wrote:
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: base address and size pair for each area representing the
> +		    shared memory. The first pair will must represent the "main"
> +		    area, where the shared memory header and table-of-content
> +		    can be found.
>
> +
> += EXAMPLE
> +
> +        smem: smem at fa00000 {
> +                compatible = "qcom,smem";
> +                reg = <0x0fa00000 0x200000>,
> +                      <0xfc428000 0x4000>;

Isn't this second entry rpm message ram? That isn't the same as smem.
Plus smem is part of ram (and rpm message ram is not) so we need to do
memory reservations or something.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
