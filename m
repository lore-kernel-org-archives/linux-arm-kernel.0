From: monstr@monstr.eu (Michal Simek)
Date: Mon, 26 Aug 2013 17:14:25 +0200
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <521B4FCF.5000904@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <20130823073250.GB30135@pengutronix.de> <521B38BF.6040400@monstr.eu>
 <20130826120716.GB24795@pengutronix.de> <521B4FCF.5000904@gmail.com>
Message-ID: <521B70D1.5090506@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2013 02:53 PM, Sebastian Hesselbarth wrote:
> On 08/26/13 14:07, Steffen Trumtrar wrote:
>> On Mon, Aug 26, 2013 at 01:15:11PM +0200, Michal Simek wrote:
>>> I agree with Soren - let's fix the current problem and then when Steffen has patches with syscon
>>> we can look at them.
>>>
>>> If there is any discussion about early syscon registration please let me know.
>>>
>>
>> Where I'm stuck at the moment is: if I map the whole register space to the
>> parent node, how do I get its mapped address in the clkc?
> 
> Steffen,
> 
> if slcr is such an essential part of the SoC, you can choose to provide
> zynq_slcr_readl/writel callbacks. You can then use those callback in the
> clock driver without knowing the base address. Also, it allows you to
> hide slcr specific locking details from subsequent drivers using the
> callbacks.

I don't think this will help. What you need to call in the clk driver is
regmap_read/regmap_write but you can call it when syscon/regmap driver
is initialized.

Steffen: Can you point me to that floading patches? If they are useful
we can try them and help with pushing them to the mainline.
I don't think that there is any reasonable solution without using these
patches.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130826/a1571de2/attachment.sig>
