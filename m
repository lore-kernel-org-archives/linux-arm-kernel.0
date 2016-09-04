From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 04 Sep 2016 21:04:59 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160903102549.GK1041@n2100.armlinux.org.uk> (Russell King's
 message of "Sat, 3 Sep 2016 11:25:49 +0100")
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160903102549.GK1041@n2100.armlinux.org.uk>
Message-ID: <878tv7jxk4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Wed, Aug 31, 2016 at 09:49:38AM +0100, Russell King - ARM Linux wrote:
>> On Tue, Aug 30, 2016 at 11:32:16PM +0200, Robert Jarzmik wrote:
>> > Russell King - ARM Linux <linux@armlinux.org.uk> writes:
>> > 
>> > > If you can wait a day or two, I'll push a branch out for everything in
>> > > all these multiple series.
>> > Sure, just ping me when you have something.
>> 
>> git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
>> 
>> should get you something suitable to test.  It's based on 4.7-rc3 plus
>> my fixes branch.
>
> Branch updated, hopefully with everything that we've agreed on so far,
> all the bug fixes, plus a few extra bits...

And retested with my 3 patches on top of it. Everything works fine :
 - CF insertion is correctly detected now !
 - AT/2 keyboard interrupts fire, keys are there, etc ...
 - the AT/2 warning is now gone

The pxa_cplds_irqs patch will make it work as before, better than today for
sure. I think edge type interrupts (such as sa1111), if they come close enough,
might be lost with the current implementation, but anyway, that's for another
time.

There is one patch in my serie that I left up to you, as I wasn't very sure
about the accuracy of my commit message, nor been able to write down all the
requirements implied on sa1111 with this additional test.

Cheers.

--
Robert
