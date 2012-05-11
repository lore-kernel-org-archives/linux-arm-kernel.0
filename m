From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Fri, 11 May 2012 14:45:44 +0530
Subject: [PATCH v2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
In-Reply-To: <CA+Bv8XbDVW_XbUbKyTziyw5LjxbymYKNWhFySBhaMeT22b-Bxw@mail.gmail.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
 <CA+Bv8XbDVW_XbUbKyTziyw5LjxbymYKNWhFySBhaMeT22b-Bxw@mail.gmail.com>
Message-ID: <CAMrsUdL8117xSFah8+qxE_8pZozuXhWv587p4UK6hacMjxYO6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 2:04 PM, Russ Dill <russ.dill@gmail.com> wrote:
> On Thu, May 10, 2012 at 6:05 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> The commit (bce492c0 ?ARM: OMAP2+: UART: Fix incorrect population of
>> default uart pads) removed default uart pads that where getting populated
>> and which was making rx pin wakeup capable. If uart pads was used in
>> different mode by any other module then it would fail since the default
>> pads took over all the uart pins forcefully. With removal of default pads
>> the rx_pad wakeup for console uart while waking up from off mode is broken.

[...]


>> + ? ? ? ? ? ? ? ?* Check if uart is used in default tx/rx mode i.e. in mux mode0
>> + ? ? ? ? ? ? ? ?* if yes then configure rx pin for wake up capability
>> + ? ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? ? if (!(rx_mode & 0x07) && !(tx_mode & 0x07))
>> + ? ? ? ? ? ? ? ? ? ? ? omap_serial_fill_uart_tx_rx_pads(bdata, uart);
>
> I realize the comment makes it clear, but it'd probably be better to
> just make the code clear. I noticed mux.h has a OMAP_MODE_GPIO(x)
> macro for testing if a mux is in mode4. Perhaps its time to start
> expanding on that, at least with a macro like:
>
> #define OMAP_MUX_MODE(x) ((x) & OMAP_MUX_MODE7)
>
> So you can do a OMAP_MUX_MODE(rx_mode) == OMAP_MUX_MODE0
>

Yes sure, will add the macro and use the same.
(will post v3 addressing the comments received so far)

--
Thanks,
Govindraj.R
