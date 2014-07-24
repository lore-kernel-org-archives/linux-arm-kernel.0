From: sam@ravnborg.org (Sam Ravnborg)
Date: Thu, 24 Jul 2014 18:12:25 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
In-Reply-To: <CAKv+Gu-B9_sgGgw9obrBGNUFSS1JcskN34s1X4PU8F5bauHT1Q@mail.gmail.com>
References: <mvmr4264i1p.fsf@hawking.suse.de>
 <CAKv+Gu8SbM_Z=ymBFb2D4EWJeo-6dWuKqE2YNOkqJTKLDEJcYA@mail.gmail.com>
 <mvm4my7j5xh.fsf@hawking.suse.de>
 <CAKv+Gu-6rUxUnF+dRuroDJqy2K2B5F0r7_bm0X-vyiuQ-83W5w@mail.gmail.com>
 <CAKv+Gu96k7GOVR85EXtro3Lt0jjiJqxyvT9cwJZ1qc6uzq97bw@mail.gmail.com>
 <mvmvbqmj3b2.fsf@hawking.suse.de>
 <CAKv+Gu_9HRwAxkJjT3KRvDbupp0yzstyq1dXsXkTu9M6swdCKQ@mail.gmail.com>
 <mvmr41aj2ob.fsf@hawking.suse.de>
 <CAKv+Gu_z4VTssLDhiQxi8DRJNEUgzrM5bFzje8NXEmBiA2vqeg@mail.gmail.com>
 <CAKv+Gu-B9_sgGgw9obrBGNUFSS1JcskN34s1X4PU8F5bauHT1Q@mail.gmail.com>
Message-ID: <20140724161225.GA11204@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 04:24:48PM +0200, Ard Biesheuvel wrote:
> On 24 July 2014 16:18, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 24 July 2014 15:40, Andreas Schwab <schwab@suse.de> wrote:
> >> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> >>
> >>> On 24 July 2014 15:26, Andreas Schwab <schwab@suse.de> wrote:
> >>>> You are not using CONFIG_MODVERSIONS.
> >>>>
> >>>
> >>> I am
> >>
> >> No, you aren't, since you say that your .cmd contains a command to
> >> create aes-glue-ce.o, which with CONFIG_MODVERSIONS it doesn't.
> >>
> >
> > OK, you're right, it contains a command to create .tmp_aes-glue-ce.o.
> > But I am still not seeing the error you are seeing, strangely enough.
> 
> OK, now I am seeing it.
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Jumping in the end of the thread here - sorry for that.

Another way to solve this would be to create two
small wrapper files:
aes-glue-neon.c - which include aes-glue.c
aes-glue-ce.c that include aes-glue.c

Then you could use standard kbuild support for building your module.
And we will not potentially break it when we change cc_o_c in the near future.

	Sam
