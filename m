From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 21 Mar 2016 16:36:42 +0100
Subject: [PATCH v5 2/4] Documentation: Bindings: Add STM32 DWMAC glue
In-Reply-To: <20160321124043.GA26873@rob-hp-laptop>
References: <1458315428-10081-1-git-send-email-alexandre.torgue@gmail.com>
 <1458315428-10081-3-git-send-email-alexandre.torgue@gmail.com>
 <CAGb2v65SvVi0cJbaaD9cYrqC3pJ9eumwhTVk11_N7r_nTZhS9g@mail.gmail.com>
 <20160321124043.GA26873@rob-hp-laptop>
Message-ID: <CAGhQ9VwS=YwgfeUuK+LzGjy3f9btVGV7bN=TATGHwQs+JW+iGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2016 at 13:40, Rob Herring <robh@kernel.org> wrote:
> On Sat, Mar 19, 2016 at 12:00:22AM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Fri, Mar 18, 2016 at 11:37 PM, Alexandre TORGUE
>> <alexandre.torgue@gmail.com> wrote:
>> > +- clocks: Must contain a phandle for each entry in clock-names.
>> > +- clock-names: Should be "stmmaceth" for the host clock.
>
> This doesn't sound like the clock input signal name...
>
>> > +              Should be "tx-clk" for the MAC TX clock.
>> > +              Should be "rx-clk" for the MAC RX clock.
>
> How can other DWMAC blocks not have these clocks? The glue can't really
> add these clocks. It could combine them into one or a new version of
> DWMAC could have a different number of clock inputs. So if there is
> variation here, then some of the bindings are probably wrong. I guess
> the only change I'm suggesting is possibly moving these into common
> binding doc.

The LPC18xx implementation probably have these clocks as well but the
LPC1850 user manual only documents the main clock. Someone with access
to the IP block doc from Synopsys should be able to check which clocks
the MAC really needs.

Rockchip bindings have two clocks named "mac_clk_rx" and "mac_clk_tx".
These are probably the same as stm32 needs so maybe use these names
and move them into the main doc and update the rockchip binding.


regards,
Joachim Eastwood
