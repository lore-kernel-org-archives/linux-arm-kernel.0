From: loic.pallardy@st.com (Loic PALLARDY)
Date: Wed, 5 Sep 2012 13:38:32 +0200
Subject: [PATCH 02/17] arm: ux500: add ccu9540 board support
In-Reply-To: <201209051042.00887.arnd@arndb.de>
References: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1346839153-6465-3-git-send-email-loic.pallardy-ext@stericsson.com>
 <201209051042.00887.arnd@arndb.de>
Message-ID: <504739B8.10604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/05/2012 12:42 PM, Arnd Bergmann wrote:
> On Wednesday 05 September 2012, Loic Pallardy wrote:
>> +MACHINE_START(U9540, "ST-Ericsson 9540 platform")
>> +       .atag_offset    = 0x100,
>> +       .map_io         = u8500_map_io,
>> +       .nr_irqs        = UX500_NR_IRQS,
>> +       .init_irq       = ux500_init_irq,
>> +       .timer          =&ux500_timer,
>> +       .handle_irq     = gic_handle_irq,
>> +       .init_machine   = u9540_init_machine,
>> +       .init_late      = ux500_init_late,
>> +MACHINE_END
>> +
>
> Please don't add another ATAG based board definition to ux500. We're closing in
> on having full support for DT booting with this platform, so your patch is just
> making it harder for us to complete this.
>
> 	Arnd
Yes I know and agree.
Please consider this patch as a temporary one waiting for 9540 support 
from Lee.

Regards,
Loic
