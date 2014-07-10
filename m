From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 Jul 2014 09:56:32 -0700
Subject: [PATCH v3 0/4] ARM: pxa: Fix out of vmalloc space bug
In-Reply-To: <20140710121010.GA1990@arch.cereza>
References: <1397066897-31826-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <alpine.LFD.2.11.1404091504240.28063@knanqh.ubzr>
 <1442455.pP6sroyjMG@avalon>
 <alpine.LFD.2.11.1404102024200.980@knanqh.ubzr>
 <20140710121010.GA1990@arch.cereza>
Message-ID: <CAOesGMiRjcWUnwsKBwK_dwWZP1EZpSVJyf5GyPkZJzP63SbS4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 5:10 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On 10 Apr 08:31 PM, Nicolas Pitre wrote:
>> On Fri, 11 Apr 2014, Laurent Pinchart wrote:
>>
>> > On Wednesday 09 April 2014 15:05:26 Nicolas Pitre wrote:
>> > > On Wed, 9 Apr 2014, Laurent Pinchart wrote:
>> > > > Hello,
>> > > >
>> > > > (Resending due to a typo in an e-mail address that caused LAKML to reject
>> > > > the mails. Sorry about the noise.)
>> > > >
>> > > > This patch set reworks Ezequiel Garcia's previous fix [1] of an out of
>> > > > vmalloc space bug on PXA2[57]x platforms caused by an attempt to map the
>> > > > start of physical uncached outside of the vmalloc space.
>> > > >
>> > > > This first three patches perform a couple of cleanups, and the last patch
>> > > > fixes the problem. I've decided to map the memory at address 0xfe000000 to
>> > > > minimize changes to the code, but this causes a bit of fragmentation of
>> > > > vmalloc space. I could map it to the very end of vmalloc space
>> > > > (0xfef00000)
>> > > > instead if preferred, which would involve replacing a mov by an ldr in
>> > > > pxa2[57]x_finish_suspend and pm_enter_standby_start.
>> > > >
>> > > > I've tested the patch set on a PXA270-based system.
>> > >
>> > > For those patches:
>> > >
>> > > Acked-by: Nicolas Pitre <nico@linaro.org>
>> >
>> > Thank you.
>> >
>> > MAINTAINERS lists three maintainers for the PXA architecture, and two git
>> > trees that seem to be either dead or even deleted. Who picks up patches for
>> > PXA ? Should I send a pull request ?
>>
>> If no one else answers, then just send a pull request to the ARM-SOC
>> team (arm at kernel.org) and CC the linux-arm-kernel mailing list.
>>
>
> What ever happened to this?

Nothing, from the looks of it. I can apply them directly unless someone objects.

Laurent, care to rebase and send a fresh copy? cc arm at kernel.org.


-Olof
