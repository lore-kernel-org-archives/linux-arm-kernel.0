From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 15 Dec 2017 09:46:49 +0800
Subject: [PATCH v2] ARM64: dts: meson-axg: add ethernet mac controller
In-Reply-To: <1513269947.2261.9.camel@baylibre.com>
References: <20171214030242.113152-1-yixun.lan@amlogic.com>
 <1513269947.2261.9.camel@baylibre.com>
Message-ID: <c0063df2-7388-ab5a-f33e-d60146445a60@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome:

On 12/15/17 00:45, Jerome Brunet wrote:
> On Thu, 2017-12-14 at 11:02 +0800, Yixun Lan wrote:
>> ---
>> Changes in v2 since [1]:
>>  - rebase to kevin's v4.16/dt64 branch
>>  - add Neil's Reviewed-by
>>  - move clock info to board.dts instead of in soc.dtsi
> 
> You got this comment regarding the pwm clock setup. the setup of the pwm clocks
> depends on the use case, so should defined depending on the requirement on the
> board
> 
Yes, I thought it was a convention to put the clock into board.dts ..

I think it's more clear if you could have a three level hierarchy:
 arch.dtsi. soc.dtsi, board.dts
   most of clock and pinctrl could go to soc.dtsi

> This is not the case for the ethmac, the clock setup will be same for every
> board, unless I missed something. the clock bindings should be defined in
> meson-axg.dtsi, I think
> 
yes, clock should be same

I will send another series to fix this
also will fold the DT separation (for soc.dtsi vs board.dts)

>>  - drop "meson-axg-dwmac" compatible string, since we didn't use this
>>    we could re-add it later when we really need.
>>  - note: to make ethernet work properly,it depend on clock & pinctrl[2],
>>    to compile the DTS, the patch [3] is required.
>>    the code part will be taken via clock & pinctrl subsystem tree.
> 
> .
> 
