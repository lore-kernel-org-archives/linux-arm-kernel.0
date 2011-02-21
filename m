From: alex@digriz.org.uk (Alexander Clouter)
Date: Mon, 21 Feb 2011 23:59:14 +0000
Subject: DreamPlug
References: <20110211173744.GE12125@jirafa.cyrius.com>
	<C838F4BE-BF4D-43BE-BF1C-137526C4BDC2@kimandjk.com>
Message-ID: <irab38-02i.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

JK Scheinberg <jk@kimandjk.com> wrote:
> 
> I received my DreamPlug a few days ago. It's up running what it came 
> with and I'd like to help get full Squeeze running on it.
> 
<shameless-self-promo>

http://www.digriz.org.uk/kirkwood

</shameless-self-promo>

Does not answer the 'kernel' question though.

> * JK Scheinberg <jk@kimandjk.com> [2011-02-11 11:47]:
>
>>> also, i see they both have exactly the same processor or SOC if it's
>>> called that.  if this is merely a repackaging then unless some of
>>> the devices (enet etc) have changed won't the exact same debian
>>> kirkwood dist install and work on this?
>> 
>> It's the same SoC, but it probably has different devices and maybe
>> some of the GPIOs are different.
>>
>> I don't know anything about the DreamPlug.  Do you know if technical
>> specs are available online?
>>
The Globalscale website implies that the NAND is a bit larger 
and uboot boots off some separate NOR flash.

http://www.globalscaletechnologies.com/t-dreamplugdetails.aspx
 
>> What needs to be done is to write a support file for the DreamPlug,
>> look at sheevaplug-setup.c and guruplug-setup.c here for an example:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/arm/mach-kirkwood;h=222c4a61519a225b2444678a72a6d66edbd1727a;hb=HEAD
>
Boot the DreamPlug and take a copy of the full kernel booting log. Copy 
the sheevaplug-setup.c code, strip out *everything* except for the 
Serial, NAND[1] and Ethernet ports sections and start from there.

Do prod me off list if you need help.

Cheers

[1] match up the size and partition table to whatever the layout looks 
	like for the existing installation

-- 
Alexander Clouter
.sigmonster says: You will win success in whatever calling you adopt.
