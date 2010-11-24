From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Nov 2010 10:22:45 +0200
Subject: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
	<AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
Message-ID: <20101124082245.GF2468@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 10:46:04AM +0530, Varadarajan, Charulatha wrote:
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>> index 48e161c..a1c6bd9 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent, struct omap_mbox **list)
>> ? ? ? ? ? ? ? ? ? ? ? ?ret = PTR_ERR(mbox->dev);
>> ? ? ? ? ? ? ? ? ? ? ? ?goto err_out;
>> ? ? ? ? ? ? ? ?}
>> + ? ? ? ? ? ? ? if (cpu_is_omap44xx())
>
>Do not use cpu_is* checks in plat-omap/*

see the previous thread.

-- 
balbi
