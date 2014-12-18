From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 Dec 2014 13:27:04 +0000
Subject: [PATCH 2/4] arm64: GICv3: change unsigned types for AArch32
 compatibility
In-Reply-To: <1418307788-17977-3-git-send-email-jean-philippe.brucker@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
 <1418307788-17977-3-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <5492D628.50708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On 11/12/14 14:23, Jean-Philippe Brucker wrote:
> -static int gic_populate_rdist(void)
> +static int __init gic_populate_rdist(void)
              ^^^^^^
This change breaks cpu hotplug. Is it intentional?

Vladimir

>  {
> -     u64 mpidr = cpu_logical_map(smp_processor_id());
> +     unsigned long mpidr = cpu_logical_map(smp_processor_id());
>       u64 typer;

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
