From: geoff@infradead.org (Geoff Levand)
Date: Wed, 16 Jul 2014 16:04:21 -0700
Subject: Kexec on arm64
In-Reply-To: <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
Message-ID: <1405551861.7262.26.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Feng,

On Wed, 2014-07-16 at 10:57 -0700, Feng Kan wrote:
> Just following up on the conversation. The cpu return address of 0 should work
> in your case. Since thats the _start of the bootloader, it will run
> some core init
> code and then put the core back in wfe. 

OK, I fixed up my code so that zero is valid cpu return address.  Arun,
could you try my latest I pushed out today?

> However, I think this
> functionality should
> be pushed back into the kernel side to provide some small page of spin
> code rather
> than depend on the bootloader. 

This method was already discussed in another thread [1] and decided
against.  With this we would need to set that spin code memory as
reserved from kernel use, and so each boot stage would leak some memory.
A system would eventually run out of memory over kexec's.

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/323440

-Geoff
