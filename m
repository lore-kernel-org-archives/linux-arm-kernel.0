From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 6 Sep 2018 12:16:15 +0200
Subject: [rfc] leds: add TI LMU backlight driver
In-Reply-To: <d96eab23-dbd9-71a6-551e-2bc99ce4a57c@ti.com>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
 <20180830201825.GA1936@amd>
 <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com>
 <20180831213030.GA23447@amd>
 <d96eab23-dbd9-71a6-551e-2bc99ce4a57c@ti.com>
Message-ID: <20180906101615.GA1467@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Well, I don't think object file size is huge problem. First,
> > "distribution" kernel with support for 6 different chips will be ~71k,
> > while your proposal will result in ~136k. Second, yes, we could put
> > ifdefs into ti-lmu data file to make it smaller.
> > 
> > Anyway, clean source code and easy maintainance is more important.
> 
> I am going to reply here and snip the rest of the chain.
> 
> My proposal is to create a ti-lmu-led-common file that contains all the common
> code.  We can have LED drivers use that common code to perform the common tasks.
> This can then be extended to other devices past, present or future that have the
> same feature set.

Sounds good. But we'll still need to have the structure with register
info, right?

> Then the register maps and LED registration can be contained in each LED driver and any additional features
> can be supported in the LED driver.  The common code will retrieve any device settings from
> the firmware that it is interested in.

>From the device tree?

> I can throw some code together and RFC the code.  This way we get the common core for the
> chips and not the bloat or messy source with a single driver.
> 
> And yes I can put this together and support it if it is needed.  I just need to go get the EVMs
> so I can test it.

Well, if possible, I'd like to see how the code would look. Example
for single LED type would be enough... If it is reasonable, I can port
it to Droid 4 or at least provide testing.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/1f5f7c15/attachment.sig>
