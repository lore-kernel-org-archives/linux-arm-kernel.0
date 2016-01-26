From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 26 Jan 2016 22:17:12 +0100
Subject: [BISECTED] v4.5-rc1 mvebu/kirkwood-pinctrl regression
In-Reply-To: <20160126202017.GI27473@lunn.ch>
References: <20160126182251.GF15550@darkstar.musicnaut.iki.fi>
 <20160126202017.GI27473@lunn.ch>
Message-ID: <56A7E258.7040006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.01.2016 21:20, Andrew Lunn wrote:
> On Tue, Jan 26, 2016 at 08:22:51PM +0200, Aaro Koskinen wrote:
>> Hi,
>>
>> On kirkwood-openrd-client SDIO stopped working, and I get the following
>> pinctrl logs:
>>
>> [    0.096502] pinctrl core: initialized pinctrl subsystem
>> [    1.765275] kirkwood-pinctrl f1010000.pin-controller: registered pinctrl driver
>> [    5.375416] kirkwood-pinctrl f1010000.pin-controller: unsupported function sdio on pin mpp12
>> [    5.383972] pinctrl core: failed to register map default (5): invalid type given
> 
> Humm.. What does
> 
> /sys/kernel/debug/pinctrl/f1010000.pin-controller/pinmux-functions show?
> 
> On my 6282 i have:
> 
> function: sdio, groups = [ mpp12 mpp13 mpp14 mpp15 mpp16 mpp17 ]
> 
> What about
> 
> /sys/kernel/debug/pinctrl/f1010000.pin-controller/pinmux-pins 
> 
> Has something already claimed it?

Nah, Aaro is right, pinctrl-mvebu is broken for mpp12 on 6281. We should
revisit static mpp mode to dynamic mpp group assignment one day.

I'll send a fix in a minute when compiling v4.5-rc1 is done.

Sebastian
