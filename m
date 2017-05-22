From: srinath.mannam@broadcom.com (Srinath Mannam)
Date: Mon, 22 May 2017 17:22:55 +0530
Subject: [PATCH] mmc: sdhci-iproc: suppress spurious interrupt with
 Multiblock read
In-Reply-To: <58554ec9-1544-318a-e912-3c5f6ee40e90@intel.com>
References: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
 <58554ec9-1544-318a-e912-3c5f6ee40e90@intel.com>
Message-ID: <CABe79T5hKmn49cKEy-KdMQ-S5HMFuhextddV=D_YY+6_QwEPUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 11:55 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 18/05/17 19:57, Srinath Mannam wrote:
>> The stingray SDHCI hardware supports ACMD12 and automatically
>> issues after multi block transfer completed.
>>
>> If ACMD12 in SDHCI is disabled, spurious tx done interrupts are seen
>> on multi block read command with below error message:
>>
>> Got data interrupt 0x00000002 even though no data
>> operation was in progress.
>>
>> This patch uses SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable
>> ACM12 support in SDHCI hardware and suppress spurious interrupt.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks Adrian...

Will it be possible to take this for Linux-4.12??

Regards,
Srinath
