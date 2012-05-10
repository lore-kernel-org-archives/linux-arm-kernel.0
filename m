From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 10 May 2012 10:45:13 +0530
Subject: [PATCH v2] gpio/omap: fix incorrect initialization of
 omap_gpio_mod_init
In-Reply-To: <1664819.7TVaX0jpJi@acer>
References: <1335770412-1344-1-git-send-email-tarun.kanti@ti.com>
 <CANOLnOO3bSxoE-8TaXd_Tz=taPOZpfQY+z-=6c7Ovfpf+FCAuw@mail.gmail.com>
 <CAC83ZvLYmPr3qTRUUTom1iOA-czef9EVcM229UMDePnw8sbA+w@mail.gmail.com>
 <1664819.7TVaX0jpJi@acer>
Message-ID: <CAC83ZvKHDWmNneK5GQgSPhdg88apymEgUr0zm1EVYjfaWG2oXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 10, 2012 at 3:06 AM, Janusz Krzysztofik
<jkrzyszt@tis.icnet.pl> wrote:
> On Mon, 7 May 2012 10:52:28 DebBarma, Tarun Kanti wrote:
>> On Sun, May 6, 2012 at 3:25 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>> > On Mon, Apr 30, 2012 at 10:20 AM, Tarun Kanti DebBarma
>> > <tarun.kanti@ti.com> wrote:
>> >> Initialization of irqenable, irqstatus registers is the common
>> >> operation done in this function for all OMAP platforms, viz. OMAP1,
>> >> OMAP2+. The latter _gpio_rmw()'s which supposedly got introduced
>> >> wrongly to take care of OMAP2+ platforms were overwriting initially
>> >> programmed OMAP1 value breaking functionality on OMAP1.
>
> Hi,
> I can confirm that my other issues with GPIO on Amstrad Delta were not
> related, and this patch is still required for GPIO interrupts hardware
> being correctly initialized on OMAP1 in 3.4-rc6. You can add my
>
> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> if you wish.
Thank you for confirming!!
--
Tarun
>
> Thanks,
> Janusz
