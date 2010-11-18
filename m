From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Thu, 18 Nov 2010 11:16:41 -0500
Subject: Calling conventions for IAR
In-Reply-To: <20101118092620.GB16907@n2100.arm.linux.org.uk>
References: <AANLkTikxL8qhzh=9DMkyJCVtAuWoq9Z__xj3up+KQhXA@mail.gmail.com>
	<20101118092620.GB16907@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinei4xKki9xHFseCUS5rm2YOab-M3dPzvjkBNTv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 4:26 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 17, 2010 at 04:29:36PM -0500, jonsmirl at gmail.com wrote:
>> Currently we are using the ARM gcc AAPCS calling conventions. I need
>> to call into an older ROM written with an IAR compiler. Can I decorate
>> the function declarations for older calling conventions like I do on
>> x86 (_fastcall, _cdelc, _stdcall, etc)? I can't figure out the right
>> thing to search for, what's a good keyword?
>
> I think you're out of luck... you're probably better off writing some
> glue assembler code to call these functions.
>

We used to use -mcallee-super-interworking to get to these IAR
routines. They are in thumb code. "-mcallee-super-interworking" has
been removed from recent gcc compilers.

I found this:
http://stuff.mit.edu/afs/sipb/project/egcs/src/egcs/gcc/config/arm/README-interworking

Which says you can decorate like this:
int call () __attribute__((interfacearm));

But that seems to be gone too:
../lib/nvm.c:5:1: warning: ?interfacearm? attribute directive ignored

-- 
Jon Smirl
jonsmirl at gmail.com
