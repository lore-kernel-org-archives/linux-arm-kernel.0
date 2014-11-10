From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Nov 2014 15:53:12 -0800
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <545C4E1F.4060401@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
 <545C4E1F.4060401@gmail.com>
Message-ID: <54614FE8.6060904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 08:44 PM, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
>
> Update devicetree binding for msm_serial to reflect msm_serial_probe()
> getting line id from the serial alias.
>
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt |   15 +++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> Index: b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> ===================================================================
> --- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> +++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> @@ -27,11 +27,18 @@ Optional properties:
>  - dmas: Should contain dma specifiers for transmit and receive channels
>  - dma-names: Should contain "tx" for transmit and "rx" for receive channels
>  
> +Additional requirements:
> +- Each UART port must have an alias correctly numbered in "aliases" node.

s/requirements/notes/
s/must/can/

It wasn't the intention to make it a requirement.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
