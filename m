From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 30 Jan 2017 11:53:24 -0800
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <20170130184934.GS16461@arm.com>
References: <22169925.OhJ0QcnbHM@localhost>
 <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
 <20170130141308.GV27312@n2100.armlinux.org.uk>
 <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
 <20170130165837.GE27312@n2100.armlinux.org.uk>
 <CAKv+Gu_jEvKdWFWB2Ofxb5ruoTYUEt1puZXBb=9Cn2kEOZO1hg@mail.gmail.com>
 <1485798092.484.5.camel@crowfest.net> <yw1xo9yofm41.fsf@unicorn.mansr.com>
 <1485801299.1085.0.camel@crowfest.net> <20170130184934.GS16461@arm.com>
Message-ID: <1485806004.1085.2.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-30 at 18:49 +0000, Will Deacon wrote:
> This was all discussed in some detail back in 2014:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/26850
> 4.html
> 
> and specifically:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/26967
> 5.html
> 
> I was initially against any emulation at all (which wasn't the right
> answer
> to the problem), but there was a productive discussion and an agreed
> solution. I'm really not keen to re-open that can of worms unless
> something
> significant has changed.
> 

Yes this is a very deep subject and it goes beyond my technical
understanding of ARM.

One point that was made in the topic is does filling up the dmesg log
really going to give an incentive to people to complain to whoever they
got the software from?  Especially in the case of beginners that may
not even know what dmesg is or what it is for?

I know moving to a single binary is a long term goal.  If I downloaded
a new version of the standard kernel and it broke my favorite piece of
software, who would I blame?  Most people would probably blame the
kernel image, not the application/software.

I know I'm mostly interested in the Raspberry PI, and that case is more
complex because the kernel, user mode software, and hardware all
originate from the same place.  But that certainly isn't the general
case for ARM.

The log once or slow down the rate of logging seems like a good
compromise.  Maybe after a certain number of logging hit, the CPU goes
back to hardware emulation if available?  
