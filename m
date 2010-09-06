From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Mon, 6 Sep 2010 09:15:57 +0200
Subject: [PATCH 0/2] ARM: factorise CPU hotplug code
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7AF5@dbde02.ent.ti.com>
References: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
	<33A307AF30D7BF4F811B1568FE7A9B181C7DC032@EXDCVYMBSTM006.EQ1STM.local>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7AF5@dbde02.ent.ti.com>
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B181C7DC10D@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

>-----Original Message-----
>From: Shilimkar, Santosh [mailto:santosh.shilimkar at ti.com]

>Generic Approach seems to be good but I think this might complicate few
>scenario's regarding how _A_ platform wants to handle the hotplug.
>

Yes. But the functions cpu_enter_lowpower and cpu_leave_lowpower()
are still preserved in platform specific files. Only the top helpers are moved out.
So, platforms can still work out their custom low power mode implementations;
which I believe can vary according to the implementation of (say independent) power
domains for each/multiple cores.

Is there anything still you think cannot be generalized?

>I let other comment on this.

Regards,
Sundar
