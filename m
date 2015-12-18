From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Fri, 18 Dec 2015 20:11:07 +0530
Subject: [PATCH v5 1/5] PCI: designware: ensure ATU is enabled before
 IO/conf space accesses
In-Reply-To: <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
 <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <CAHM4w1kzGKahVOTdTxMciZBs81U9EVoSYPgCw9=ph3R9vSwCwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 6:08 PM, Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
> There is no guarantees that enabling ATU will hit the hardware
> immediately, and subsequent accesses to configuration / IO spaces
> are reliable. So fixing this by read back PCIE_ATU_CR2 register
> just after writing.
>
> Without such a fix the PCI device enumeration during kernel boot
> is not reliable, and reading configuration space for particular
> PCI device on the bus returns zero aka no device.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
