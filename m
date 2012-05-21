From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 21 May 2012 15:09:38 +0530
Subject: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
In-Reply-To: <1337592906.28274.16.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-15-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
 <1337592906.28274.16.camel@sokoban>
Message-ID: <CAMQu2gx7NL0Hv9GVtX=WDJY8sB8NoX4oN390NurQ0gvRa=WPYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 3:05 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-05-16 at 18:17 -0600, Paul Walmsley wrote:
>> Hi Tero
>>
>> On Mon, 14 May 2012, Tero Kristo wrote:
>>
>> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
>> > otherwise the secure ROM code will crash.
>>
>> Do we know why the l3_main_3 interconnect has to be enabled? ?Is this
>> needed to access some L3 or instrumentation registers?
>
> Not sure, ROM code is doing something here which requires it, and the
> ROM code definitely crashes without this. Your guess sounds plausible.
>
ROM code accesses L3 firewall registers mostly apart from L2 INSTR firewall
registers here and without that clock, those accesses will abort.

Regards
santosh
