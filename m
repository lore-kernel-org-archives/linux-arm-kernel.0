From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Wed, 1 Dec 2010 20:10:00 -0600
Subject: [RFC v2 1/8] TILER-DMM: DMM-PAT driver for TI TILER
In-Reply-To: <AANLkTi=q1HzYBpMH_pP+S5BtBQpHs62+zNfd_MtWHFuu@mail.gmail.com>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
	<1291147139-23472-2-git-send-email-davidsin@ti.com>
	<AANLkTi=q1HzYBpMH_pP+S5BtBQpHs62+zNfd_MtWHFuu@mail.gmail.com>
Message-ID: <AANLkTi=YUYuxQE8pDZrN5-PJq1Q3jw7cP2yZKCXNAvPP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 1, 2010 at 12:04 AM, Varadarajan, Charulatha <charu@ti.com> wrote:
> David,

>
>> + ? ? ? ? ? ? ? if (!oh)
>> + ? ? ? ? ? ? ? ? ? ? ? goto error;
>> +
>> + ? ? ? ? ? ? ? data->base = oh->_mpu_rt_va;
>
> not required. Make use of platform_get APIs in probe to extract the
> base, dma and irq info using pdev.

Not sure about using platform_get APIs. I think one has to use
omap_hwmod_get_mpu_rt_va to get the address, which internally returns
oh-<_mpu_rt_va.
omap_hwmod_get_mpu_rt_va was added so that the individual drivers can
avoid doing the ioremap.
check the discussion regarding this.
http://www.spinics.net/lists/linux-omap/msg33048.html


Thank you,
Best regards,
Hari Kanigeri
