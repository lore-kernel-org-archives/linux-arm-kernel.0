From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 8 May 2018 15:47:04 +0100
Subject: [PATCH 01/11] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
In-Reply-To: <1524759514-12392-2-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
 <1524759514-12392-2-git-send-email-ludovic.Barre@st.com>
Message-ID: <20a1b5f0-7494-01a9-635f-c46c337a23b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/18 17:18, Ludovic Barre wrote:
> From: radek <radoslaw.pietrzyk@gmail.com>
> 
> - In stm32_exti_alloc function, discards irq_domain_set_info
>   with handle_simple_irq. This overwrite the setting defined while init
>   of generic chips. Exti controller manages edge irq type.
> - Removes acking in chained irq handler as this is done by
>   irq_chip itself inside handle_edge_irq
> - removes unneeded irq_domain_ops.xlate callback
> 
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
> Acked-by: Ludovic Barre <ludovic.barre@st.com>
> Tested-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Nit: the "From:" should match the SoB line (the address does, but not
the name). I can fix that up when I apply the series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
