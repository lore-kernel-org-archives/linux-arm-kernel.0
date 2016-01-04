From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Mon, 4 Jan 2016 16:31:27 +0200
Subject: [PATCH v5 1/5] PCI: designware: ensure ATU is enabled before
 IO/conf space accesses
In-Reply-To: <CAHM4w1kzGKahVOTdTxMciZBs81U9EVoSYPgCw9=ph3R9vSwCwQ@mail.gmail.com>
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
 <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
 <CAHM4w1kzGKahVOTdTxMciZBs81U9EVoSYPgCw9=ph3R9vSwCwQ@mail.gmail.com>
Message-ID: <568A823F.5090209@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2015 04:41 PM, Pratyush Anand wrote:
> On Fri, Dec 18, 2015 at 6:08 PM, Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>> There is no guarantees that enabling ATU will hit the hardware
>> immediately, and subsequent accesses to configuration / IO spaces
>> are reliable. So fixing this by read back PCIE_ATU_CR2 register
>> just after writing.
>>
>> Without such a fix the PCI device enumeration during kernel boot
>> is not reliable, and reading configuration space for particular
>> PCI device on the bus returns zero aka no device.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
> Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

Bjorn, Do you want to resend the whole patchset with collected acks and
tested tags?


-- 
regards,
Stan
