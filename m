From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 2 May 2010 18:05:32 +0300
Subject: [PATCH 3/5] USB: add clk structure for systems that support
	clkdev framework
In-Reply-To: <20100502143602.GA4233@n2100.arm.linux.org.uk>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
	<1272810162-14858-2-git-send-email-saeed@marvell.com>
	<1272810162-14858-3-git-send-email-saeed@marvell.com>
	<1272810162-14858-4-git-send-email-saeed@marvell.com>
	<20100502143602.GA4233@n2100.arm.linux.org.uk>
Message-ID: <r2oc70ff3ad1005020805zc80ad8b9n1e56d4a0a6ce5b9c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 2, 2010 at 5:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, May 02, 2010 at 05:22:40PM +0300, Saeed Bishara wrote:
>> @@ -110,6 +111,9 @@ struct usb_hcd {
>> ? ? ? u64 ? ? ? ? ? ? ? ? ? ? rsrc_start; ? ? /* memory/io resource start */
>> ? ? ? u64 ? ? ? ? ? ? ? ? ? ? rsrc_len; ? ? ? /* memory/io resource length */
>> ? ? ? unsigned ? ? ? ? ? ? ? ?power_budget; ? /* in mA, 0 = no limit */
>> +#if defined(CONFIG_HAVE_CLK)
>> + ? ? struct clk ? ? ? ? ? ? ?*clk;
>> +#endif
>
> We have other hci's using the clk API, why do we need to add this for
> them too? ?In other words, why can't the orion HCI driver work like
> the other HCI drivers such as ohci-pxa27x.c or ehci-omap.c ?
>
if most of those drivers need clk structure then why not to add it to
the usb_hcd which hold the common stuff?
if I get approval for this then we can change the other drivers to use
this clk instead of each one having its own variable.

saeed
