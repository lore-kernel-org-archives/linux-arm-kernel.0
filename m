From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 7 Jul 2015 15:49:31 +0300
Subject: [PATCH v2 0/5] Add support for PWMSS on DRA7
In-Reply-To: <559A1C1F.7000309@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
 <559A1C1F.7000309@ti.com>
Message-ID: <559BCADB.4070606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2015 09:11 AM, Vignesh R wrote:
>
>
> On Wednesday 03 June 2015 05:21 PM, Vignesh R wrote:
>>
>> Hi,
>>
>> This patch series adds support for PWMSS on DRA7. The IP is same as that
>> present in AM33XX and AM43XX.
>> The first patch changes clock domain in which PWMSS is present
>> (l4per2_7xx_clkdm) to SW_WKUP. This is because legacy IPs like PWM
>> does'nt support HW_AUTO prorperly. Hence, switch clock domain to
>> SW_WKUP. This is based on the input from the hardware team.
>> The rest of the patches add hwmod and dt entries and enable PWMSS on
>> DRA7 based SoCs.
>
> Gentle ping...
>
>

Patches 1-4 look good to me, not going to try to review patch 5 as I 
have no clue about PWM driver itself. So, for 1-4:

    Acked-by: Tero Kristo <t-kristo@ti.com>

Some of the patches cause trivial merge conflicts with 4.2-rc1 though.

-Tero
