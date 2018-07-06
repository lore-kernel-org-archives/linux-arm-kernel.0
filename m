From: faiz_abbas@ti.com (Faiz Abbas)
Date: Fri, 6 Jul 2018 15:34:31 +0530
Subject: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
In-Reply-To: <20180705154758.GA112168@atomide.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-5-faiz_abbas@ti.com>
 <20180705154758.GA112168@atomide.com>
Message-ID: <cf8652a1-019c-d423-9b44-0d62006734f8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 05 July 2018 09:17 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180705 14:24]:
>> +static int sysc_reset(struct sysc *ddata)
>> +{
>> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
>> +	int val = sysc_read(ddata, offset);
> 
> Can you please just warn and return early for now if no
> syss_mask is specified? Otherwise we'll have mysterious
> errors if somebody leaves out "ti,hwmods" for module types
> we do not yet support reset for.

RESET write to sysconfig can still happen even if there's no syss_mask
right? Not all modules need to poll on reset status.

Thanks,
Faiz
