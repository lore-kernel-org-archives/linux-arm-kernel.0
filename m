From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 26 Aug 2014 14:31:09 -0400
Subject: Generic communication of boot loader state to the OS
In-Reply-To: <20140826171658.GJ4078@leverpostej>
References: <CAKON4Oz-PRgXyNKj=T9ymzOOhCMPjBMdYdE1Mr1CHWv3boskiw@mail.gmail.com>
 <20140826171658.GJ4078@leverpostej>
Message-ID: <CAKON4OyENsHnPc528zLnimVY-B2x6-gdBQ6iyYHO60PgHdnvWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 1:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Jon,
>
> On Tue, Aug 26, 2014 at 05:10:00PM +0100, jonsmirl at gmail.com wrote:
>> New thread split off from the simple-framebuffer discussion....
>>
>> Is there a generic, underlying problem here that needs to be solved?
>> AFAIK no one has designed a general purpose mechanism for
>> communicating boot loader state to the OS. There is the existing
>> device tree <chosen> node but it is limited compared to what is
>> needed. Maybe we should step back and first design a good solution to
>> this basic problem. Then specific solutions for things like
>> framebuffers would fall out of the basic design.
>
> I think the fundamental problem here is unfortunately far too abstract
> for the general solution to be any more concrete. The solution to "we
> don't communicate boot state" is "we should communicate boot state".
>
> We can perhaps come up with general guidelines (for instance, the clock
> subsystem has assigned-* properties), but I don't think there's a
> one-size-fits-all solution.

I think it worth taking some time to consider if a one-size-fits-all
solution exists for the general issues of communicating between the
boot loader and the OS. Things are a lot better now, but I can
remember have 20K byte long kernel command lines in the past.  Some
random thoughts...

Do we even need a kernel command line any more?
Could EARLY_PRINTK be made automatic with cooperation from the bootloader?
Can we make it all the way from the boot loader to the GUI without
having the display flash from mode setting?
Can I not auto-negotiate network links speed twice (a slow process)?
Can 23 years of different solutions be collapsed into a general framework?

-- 
Jon Smirl
jonsmirl at gmail.com
