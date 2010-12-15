From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 15 Dec 2010 12:24:43 +0100
Subject: [PATCH RFC] i.MX51 Framebuffer support
In-Reply-To: <4D088BEE.3030709@bitbox.co.uk>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<4D088BEE.3030709@bitbox.co.uk>
Message-ID: <20101215112443.GC6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 09:35:42AM +0000, Peter Horton wrote:
> On 09/12/2010 13:47, Sascha Hauer wrote:
>>
>> The following series adds i.MX51 framebuffer support based on the IPUv3. It
>> is not perfect but I decided it is good enough to open it for a wider audience
>> and collect first reviews. I tested this on a babbage board using both outputs
>> (VGA/DVI) with different resolutions up to 1680x1050 and different colour depths.
>> I also tested it on one custom board using a fixed display setting.
>>
>
> Good stuff, almost works here :)
>
> Custom board with an HDMI bridge hooked to DI0.
>
> About 50% of power ups fail to show a display because the DE signal is  
> bogus. It appears to be correct for the active window but remains active  
> for the vertical blanking period. If the DE signal is correct we get a  
> good display. I've tried investigating but the IPU section of the manual  
> is unfathomable (and that's just the section on the waveform generator).

I just learned a new word. 'unfathomable' really is the right word for
this ;)
I think it's nearly impossible to write a driver based only on the
datasheet.

>
> Resizing the display to a larger size sometimes shows a square of solid  
> colour on the display, hardware cursor perhaps ?

I don't know, but I can't imagine the hardware cursor gets activated
accidently.

>
> Every now and then changing the video mode causes the kernel to hang  
> hard. Unfortunately this is not very reproduceable.

I'll try to reproduce it here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
