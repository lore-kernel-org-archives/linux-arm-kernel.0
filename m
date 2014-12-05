From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 05 Dec 2014 07:01:17 -0800
Subject: [PATCH 2/3] drivers:input:ps2 Added sunxi A20 ps2 driver,
 changed makefile and Kconfig
In-Reply-To: <12237550.afophX20rO@wuerfel>
References: <1417647224-27950-1-git-send-email-VishnuPatekar0510@gmail.com>
 <12237550.afophX20rO@wuerfel>
Message-ID: <63D786FF-B293-4FC1-AD71-D99515DE8E3D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On December 5, 2014 2:33:11 AM PST, Arnd Bergmann <arnd@arndb.de> wrote:
>On Thursday 04 December 2014 04:23:44 vishnupatekar wrote:
>> +
>> +struct sunxips2data {
>> +	int irq;
>> +	spinlock_t ps2_lock;
>> +	void __iomem *base_address;	/* virt address of control registers*/
>> +	struct serio *serio;		/* serio*/
>> +	struct device *dev;
>> +	struct	clk	*pclk;
>> +};
>
>As this is dynamically allocated, better embed the serio member
>directly to avoid allocating both separately.

That would be wrong - serio is refcounted and it may outlive instance of sunxips2data you embedded it into.


Thanks.

-- 
Dmitry
