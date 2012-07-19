From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 19 Jul 2012 15:02:00 -0700
Subject: [PATCH 4/4] ARM: clps711x: Added simple clkdev framework
In-Reply-To: <201207172033.10302.arnd@arndb.de>
References: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
 <1342462908-18547-4-git-send-email-shc_work@mail.ru>
 <201207172033.10302.arnd@arndb.de>
Message-ID: <CAJOA=zMB83pT1ESnHBgAZotn4cVysP6pKWDXOoRp-sMNMjGkVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 1:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 16 July 2012, Alexander Shiyan wrote:
>> Modern CPUs from CLPS711X-line can operate at frequencies other than 73 MHz.
>> This patch adds simple clkdev framework for handling all possible CPU rates.
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>
> +Mike Turquette
>
> We just had the exact same discussion about a new clock implementation for
> mcs814x and for the socfpga port. My feeling is that it makes no sense
> to keep adding new private implementations of the API as we're trying
> to get rid of the existing ones and replace them with the common code.
>
> If I understand this correctly, you should be using DEFINE_CLK_FIXED_RATE
> and DEFINE_CLK_DIVIDER etc to define the initial clocks and the lookup
> table, and possibly move all of that to drivers/clk.
>

Arnd is correct.  Let's go ahead and move everything over to the
common clk framework.  These patches will have to wait for 3.7
anyways, so there is plenty of time to port it over.

Regards,
Mike
