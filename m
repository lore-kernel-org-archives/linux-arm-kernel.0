From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Oct 2018 10:57:41 +0100
Subject: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com>
References: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
 <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com>
Message-ID: <20181010095741.GA14472@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 12:18:32AM -0700, Wendy Liang wrote:
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>

[...]

> +Optional properties:
> +--------------------
> +- method:              The method of accessing the IPI agent registers.
> +                       Permitted values are: "smc" and "hvc". Default is
> +                       "smc".

You are mixing the hardware messaging based mailbox and the software
"smc/hvc" based mailbox together here. Please keep them separated.
IIUC smc/hvc based mailcox is used for "tx" or too keep it simple in
one direction and hardware based is used for "rx" or the other direction
for communication.

You *should not* mix them as single unit. Also lots of other vendor need
SMC/HVC based mailbox. So make it generic and keep it separate.

--
Regards,
Sudeep
