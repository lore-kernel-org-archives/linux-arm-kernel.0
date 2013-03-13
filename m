From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 12:26:07 -0600
Subject: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <CACRpkdZ14k_o-aO248NZJ6-jqxJf8AYhsZHLN_wPToyU1NsM6w@mail.gmail.com>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
 <CACRpkdZ14k_o-aO248NZJ6-jqxJf8AYhsZHLN_wPToyU1NsM6w@mail.gmail.com>
Message-ID: <5140C4BF.3010708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 10:11 AM, Linus Walleij wrote:
> On Sat, Mar 9, 2013 at 6:39 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> 
>> This patch adds support for the GPIO/pinmux controller found on the VIA
>> VT8500 and Wondermedia WM8xxx-series SoCs.
> (...)

>> +static int wmt_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,

>> +       for (i = 0; i < num_pins; i++) {
>> +               pin = prop_u32(pins, i);
> 
> So I don't get this. What is wrong with of_property_read_u32()?
> 
> I think there is something very strange about this parsing code
> if you can't use the common accessors to get the stuff you want,
> if you really need to inspect properties like that static inline does,
> then it should be explained and the function should *not* be in
> this driver but a helper in <linux/of_*> somewhere.

There is no of_property_read_u32_index(), which would read the nth u32
in a list of them. You're right there probably should be. My fault for
not creating one when I first wrote that code in the Tegra driver:-(
