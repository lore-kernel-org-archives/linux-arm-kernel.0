From: koen@dominion.thruhere.net (Koen Kooi)
Date: Sat, 26 Feb 2011 09:28:36 +0100
Subject: [PATCH] OMAP4: PandaBoard: Adding DVI support
In-Reply-To: <AANLkTikQ25tLoRSynp6xjaJPO0sPpY3RFFS52UsgBuvU@mail.gmail.com>
References: <1297259727-19690-1-git-send-email-raghuveer.murthy@ti.com>
	<AANLkTimwCDYGfeXc=mW-1wyvSj+OGHd_fJMB7Grh60ih@mail.gmail.com>
	<AANLkTimQxC3HgaRs-bBOGChLhvAK69XHCPEGyOcKeOz6@mail.gmail.com>
	<F55C15BA-2C89-4DB7-9930-5176AA72C2A7@dominion.thruhere.net>
	<AANLkTikQ25tLoRSynp6xjaJPO0sPpY3RFFS52UsgBuvU@mail.gmail.com>
Message-ID: <73BD8D5C-D213-47EC-8C81-D99DCEEA0EA1@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 25 feb 2011, om 19:57 heeft Jan, Sebastien het volgende geschreven:

> On Fri, Feb 11, 2011 at 4:38 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>>> I fetched this branch which contains 35 patches on top of 2.6.38-rc4.
>>> After fixing some conflict, I applied these 35 patches on our Ubuntu
>>> ti-omap-dev kernel. With built-in the DSS2 driver and GENERIC_DPI
>>> driver, kernel boots fine on my Panda with Ubuntu GUI. But I have to
>>> set the kernel boot command args with omapfb.mode=dvi:1024x768MR-24 at 60
>>> omapdss.def_disp=dvi, pointed out by Sebastien. Without this bootargs,
>>> no graphic at all. so as Robert concerned, EDID detection doesn't
>>> work. Does that related to I2C driver? I2C driver always tell me
>>> timeout in dmesg.
>> 
>> AIUI the i2c bus is only hooked up to the HDMI port, so unless you plug in something there, no dice.
> 
> Are you sure? According to the pandaboard user manual, there seem to
> be an i2c connection (i2c3): page 31, fig 9:
> http://pandaboard.org/sites/default/files/board_reference/A1/Panda_Board_Spec_DOC-21010_REV0_6.pdf

And so it does, it's nice to have a DDC bus on each port. I guess I got confused by the fact no kernel is using that currently :)

regards,

Koen
