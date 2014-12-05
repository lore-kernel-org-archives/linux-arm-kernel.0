From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 05 Dec 2014 07:53:46 -0800
Subject: [PATCH 2/3] drivers:input:ps2 Added sunxi A20 ps2 driver,
 changed makefile and Kconfig
In-Reply-To: <2906898.Fr1ixVkiAI@wuerfel>
References: <1417647224-27950-1-git-send-email-VishnuPatekar0510@gmail.com>
 <12237550.afophX20rO@wuerfel>
 <63D786FF-B293-4FC1-AD71-D99515DE8E3D@gmail.com> <2906898.Fr1ixVkiAI@wuerfel>
Message-ID: <59842F96-3A97-4DBE-9A92-10BFA9179E48@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On December 5, 2014 7:50:18 AM PST, Arnd Bergmann <arnd@arndb.de> wrote:
>On Friday 05 December 2014 07:01:17 Dmitry Torokhov wrote:
>> 
>> On December 5, 2014 2:33:11 AM PST, Arnd Bergmann <arnd@arndb.de>
>wrote:
>> >On Thursday 04 December 2014 04:23:44 vishnupatekar wrote:
>> >> +
>> >> +struct sunxips2data {
>> >> +    int irq;
>> >> +    spinlock_t ps2_lock;
>> >> +    void __iomem *base_address;     /* virt address of control
>registers*/
>> >> +    struct serio *serio;            /* serio*/
>> >> +    struct device *dev;
>> >> +    struct  clk     *pclk;
>> >> +};
>> >
>> >As this is dynamically allocated, better embed the serio member
>> >directly to avoid allocating both separately.
>> 
>> That would be wrong - serio is refcounted and it may outlive instance
>of sunxips2data you embedded it into.
>
>Ok, I see. I guess in this case the use of devm_kzalloc for serio is a
>bug,
>because that would lead to a double free upon module unload, right?
>

Exactly. I already mentioned that in my review.

Thanks.

-- 
Dmitry
