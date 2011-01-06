From: phorton@bitbox.co.uk (Peter Horton)
Date: Thu, 06 Jan 2011 10:32:26 +0000
Subject: [PATCH v2] i.MX51 Framebuffer support
In-Reply-To: <20110106102310.GF26009@pengutronix.de>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>	<4D246C54.9060503@free.fr>
	<20110106102310.GF26009@pengutronix.de>
Message-ID: <4D259A3A.7060104@bitbox.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2011 10:23, Sascha Hauer wrote:
> On Wed, Jan 05, 2011 at 02:04:20PM +0100, Julien Boibessot wrote:
>> Hello,
>>
>> Sascha Hauer a ?crit :
>>> The following series adds i.MX51 framebuffer support based on the IPUv3. It
>>> is not perfect but I decided it is good enough to open it for a wider audience
>>> and collect first reviews. I tested this on a babbage board using both outputs
>>> (VGA/DVI) with different resolutions up to 1680x1050 and different colour depths.
>>> I also tested it on one custom board using a fixed display setting.
>>>
>> This driver is also working fine for me on a custom i.MX51 board with a
>> 800x480 18 bits TFT LCD (16bpp mode).
>>
>> The only strange thing I noticed was a kind of uggly sprite/artefact
>> (32x32, I would say) appearing at the same time as the Linux console. I
>> think it may be related to a hardware cursor badly (?) initialised, but
>> I didn't find a fix yet.
>> It disappears when I launch a graphical application (Qt or SDL).
>
> It may be the penguin, but I remember a similar report also talkling
> about hardware cursors. I can't reproduce this. You could search for
> cursor in the IPU section of the manual and play with the corresponding
> registers.
>

We see this too, but only when increasing resolution from the kernel 
default. We get a yellow square appear in the lower right quadrant of 
the display.

P.
