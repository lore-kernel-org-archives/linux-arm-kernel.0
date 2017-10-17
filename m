From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Tue, 17 Oct 2017 10:06:39 -0400
Subject: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
In-Reply-To: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <9287b646-7673-bf5d-bcde-933c8c98a0dd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2017 4:02 AM, Dongjiu Geng wrote:
> For the SEA notification, the two functions ghes_sea_add() and
> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
> is defined. If not, it will return errors in the ghes_probe()
> and not continue. If the probe is failed, the ghes_sea_remove()
> also has no chance to be called. Hence, remove the unnecessary
> handling when CONFIG_ACPI_APEI_SEA is not defined.
>
> For the NMI notification, it has the same issue as SEA notification,
> so also remove the unused dead-code for it.
>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

I've verified v5 of this series testing the SEA path.

Thanks,
Tyler
