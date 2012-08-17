From: alanbutty12@gmail.com (Alan M Butler)
Date: Fri, 17 Aug 2012 23:19:07 +0100
Subject: Issues with all kernels after 3.3.7
In-Reply-To: <CADhrpJ4=VdsEat7TWYTWx=HGUKqQNAcnV5zK5aQAzFvcN89pqw@mail.gmail.com>
References: <CADhrpJ7r4PPM2nOD7Wch9H+usaDUJ5XYeim6THUKEDTz=-Zyig@mail.gmail.com>
 <CADhrpJ798WD8rLbLY+XYbOvU4LacCeoVGM9SUYtHu6jD2Dtm9g@mail.gmail.com>
 <CADhrpJ6LsBXvJiOkOhHNibvazHY0ymREoZ4c2ztQR-RCKD50Mg@mail.gmail.com>
 <2094430.QvfuTg7dJ7@flatron>
 <CADhrpJ4=VdsEat7TWYTWx=HGUKqQNAcnV5zK5aQAzFvcN89pqw@mail.gmail.com>
Message-ID: <CADhrpJ44UJOj+tXk++FPsano7=fghv31hiwstK9bSkti2+aGWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2012 22:04, Alan M Butler <alanbutty12@gmail.com> wrote:
> On 17 August 2012 21:23, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> On Friday 17 of August 2012 21:19:08 Alan M Butler wrote:
>>> On 17 August 2012 21:08, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> > Hi Alan,
>>> >
>>> > On Friday 17 of August 2012 20:37:08 Alan M Butler wrote:
>>> >> On 17 August 2012 19:12, Alan M Butler <alanbutty12@gmail.com> wrote:
>>> >> > From: Alan M Butler <alanbutty12@gmail.com>
>>> >> > Date: 17 August 2012 18:09
>>> >> > Subject: Re: Issues with all kernels after 3.3.7
>>> >> > To: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>> >> >
>>> >> >
>>> >> > On 17 August 2012 17:46, Uwe Kleine-K?nig
>>> >> >
>>> >> > <u.kleine-koenig@pengutronix.de> wrote:
>>> >> >> Hello,
>>> >> >>
>>> >> >> On Fri, Aug 17, 2012 at 05:30:27PM +0000, Alan M Butler wrote:
>>> >> >>> On 17 August 2012 14:01, Alan M Butler <alanbutty12@gmail.com>
>> wrote:
>>> >> >>> > On 17 August 2012 13:26, Uwe Kleine-K?nig
>>> >> >>> >
>>> >> >>> > <u.kleine-koenig@pengutronix.de> wrote:
>>> >> >>> >> On Fri, Aug 17, 2012 at 01:47:06PM +0100, alan butler wrote:
>>> >> >>> >>> I have been trying all kernels after 3.3.7 (except for the 3.5
>>> >> >>> >>> series)
>>> >> >>> >>> on my ix2-200
>>> >> >>> >>> and have found that on every kernel 3.3.8, 3.4, 3.4.2, 3.4.4
>>> >> >>> >>> =>3.4.7
>>> >> >>> >>> and now even on 3.6 rc1
>>> >> >>> >>> and the next dated today 17 august that when i use git for
>>> >> >>> >>> example:
>>> >> >>> >>>
>>> >> >>> >>> git clone git://git.videolan.org/x264
>>> >> >>> >>>
>>> >> >>> >>> my system just crash's / hangs and even through the serial
>>> >> >>> >>> port i
>>> >> >>> >>> get
>>> >> >>> >>> no response.
>>> >> >>> >>> This also happens when i try to access a web interface for
>>> >> >>> >>> example the
>>> >> >>> >>> serviio java webui.
>>> >> >>> >>>
>>> >> >>> >>> The second issue i have noticed is that my raid 0 array hangs
>>> >> >>> >>> /
>>> >> >>> >>> pauses
>>> >> >>> >>> when being mounted
>>> >> >>> >>> at system startup. (for approximatly 30 seconds maybe more
>>> >> >>> >>> maybe
>>> >> >>> >>> less
>>> >> >>> >>> im not certain).
>>> >> >>> >>> But again on the 3.3.7 kernel there was no issue and no hang.
>>> >> >>> >>>
>>> >> >>> >>> If i return to 3.3.7 everything works fine with no other
>>> >> >>> >>> modifications
>>> >> >>> >>> to the os or kernels.
>>> >> >>> >>> I am using debian wheezy at the moment but also tried debian
>>> >> >>> >>> squeeze
>>> >> >>> >>> so it does not
>>> >> >>> >>> seem to be related to the specific linux version just the
>>> >> >>> >>> kernel.
>>> >> >>> >>
>>> >> >>> >> Can you bisect your problem? Doing that between 3.3.7 and 3.3.8
>>> >> >>> >> seems to
>>> >> >>> >> be the obvious range to test.
>>> >> >>> >>
>>> >> >>> >> You can also try to enable the various debugging options like
>>> >> >>> >>
>>> >> >>> >>         CONFIG_DETECT_HUNG_TASK
>>> >> >>> >>         CONFIG_PROVE_LOCKING
>>> >> >>> >>         CONFIG_DEBUG_ATOMIC_SLEEP
>>> >> >>> >>         CONFIG_MAGIC_SYSRQ
>>> >> >>> >>
>>> >> >>> >> or try https://lkml.org/lkml/2012/5/26/83.
>>> >> >>> >>
>>> >> >>> >> Best regards
>>> >> >>> >> Uwe
>>> >> >>> >>
>>> >> >>> >> --
>>> >> >>> >> Pengutronix e.K.                           | Uwe Kleine-K?nig
>>> >> >>> >>
>>> >> >>> >>       | Industrial Linux Solutions                 |
>>> >> >>> >>
>>> >> >>> >> http://www.pengutronix.de/  |>>> >
>>> >> >>> >
>>> >> >>> > i enabled the options you said there and i see alot of the
>>> >> >>> > following
>>> >> >>> >
>>> >> >>> > popping up while connected through serial:
>>> >> >>> >  BUG: sleeping function called from invalid context at
>>> >> >>> >
>>> >> >>> > include/linux/freezer.h:46
>>> >> >>> > [  126.896958] in_atomic(): 0, irqs_disabled(): 128, pid: 2180,
>>> >> >>> > name:
>>> >> >>> > console-kit-dae
>>> >> >>> > [  126.904566] no locks held by console-kit-dae/2180.
>>> >> >>> > [  126.909378] irq event stamp: 27643
>>> >> >>> > [  126.912797] hardirqs last  enabled at (27642): [<c03781ac>]
>>> >> >>> > _raw_spin_unlock_irqrestore+0x3c/0x5c
>>> >> >>> > [  126.921735] hardirqs last disabled at (27643): [<c00090cc>]
>>> >> >>> > ret_fast_syscall+0xc/0x38
>>> >> >>> > [  126.929618] softirqs last  enabled at (25565): [<c001bc20>]
>>> >> >>> > irq_exit+0x54/0xb8
>>> >> >>> > [  126.936890] softirqs last disabled at (25558): [<c001bc20>]
>>> >> >>> > irq_exit+0x54/0xb8
>>> >> >>> > [  126.944185] [<c000ea8c>] (unwind_backtrace+0x0/0xe0) from
>>> >> >>> > [<c000b414>] (do_signal+0x84/0x5c0)
>>> >> >>> > [  126.952764] [<c000b414>] (do_signal+0x84/0x5c0) from
>>> >> >>> > [<c000be0c>]
>>> >> >>> > (do_notify_resume+0x18/0x60)
>>> >> >>> > [  126.961430] [<c000be0c>] (do_notify_resume+0x18/0x60) from
>>> >> >>> > [<c0009120>] (work_pending+0x24/0x28)
>>> >> >>> >
>>> >> >>> > there seems to be alot more of them when i have serviio upnp
>>> >> >>> > server
>>> >> >>> > running.>>>
>>> >> >>>
>>> >> >>> After a little testing with those config options enabled that you
>>> >> >>> sujested iv found that the problem with git first appears in the
>>> >> >>> 3.4.1
>>> >> >>> kernel.
>>> >> >>> For example:
>>> >> >>> in 3.4.0 kernel i can use 'git clone git://git.videolan.org/x264'
>>> >> >>> successfully.
>>> >> >>>
>>> >> >>> From 3.4.1 kernel on  I can not use 'git clone
>>> >> >>> git://git.videolan.org/x264' the system hangs / crashes with no
>>> >> >>> output
>>> >> >>> at all.
>>> >> >>>
>>> >> >>> the other issue the hang / stall while mounting my etx4 raid 0 is
>>> >> >>> actualy much more recent than i remembered i have tested each
>>> >> >>> kernel
>>> >> >>> from 3.4.0 all the way to 3.4.9 with the config options enabled as
>>> >> >>> sujested before and the stall first starts in kernel 3.4.8 and the
>>> >> >>> following bug keeps popping up repeatedly until the raid is
>>> >> >>> mounted
>>> >> >>> and then anytime a disk is accessed it seems. I was certain it had
>>> >> >>> been popping up before 3.4.8.
>>> >> >>>
>>> >> >>> The following is one of what pops up:
>>> >> >>>  BUG: sleeping function called from invalid context at
>>> >> >>>
>>> >> >>> include/linux/freezer.h:46
>>> >> >>> in_atomic(): 0, irqs_disabled(): 128, pid: 2166, name: minissdpd
>>> >> >>> no locks held by minissdpd/2166.
>>> >> >>>
>>> >> >>>  irq event stamp: 2081
>>> >> >>>
>>> >> >>> hardirqs last  enabled at (2080): [<c02f8dc8>]
>>> >> >>> _raw_spin_unlock_irq+0x24/0x4c hardirqs last disabled at (2081):
>>> >> >>> [<c00090cc>] ret_fast_syscall+0xc/0x38 softirqs last  enabled at
>>> >> >>> (0): [<c0016b38>] copy_process+0x3f8/0xfe8 softirqs last disabled
>>> >> >>> at
>>> >> >>> (0): [<  (null)>]   (null)
>>> >> >>> [<c000eae4>] (unwind_backtrace+0x0/0xe0) from [<c000b5a0>]
>>> >> >>> (do_signal+0x84/0x554)
>>> >> >>> [<c000b5a0>] (do_signal+0x84/0x554) from [<c000bec0>]
>>> >> >>> (do_notify_resume+0x18/0x60)
>>> >> >>> [<c000bec0>] (do_notify_resume+0x18/0x60) from [<c0009120>]
>>> >> >>> (work_pending+0x24/0x28)
>>> >> >>
>>> >> >> I think this is an unrelated issue that I think is fixed in later
>>> >> >> kernels. So I'd disable CONFIG_DEBUG_ATOMIC_SLEEP for further
>>> >> >> testing.
>>> >> >> Can you try a bisection, i.e.
>>> >> >>
>>> >> >>         git clone
>>> >> >>         git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu
>>> >> >>         x.
>>> >> >>         git cd linus
>>> >> >>         git remote add -f stable
>>> >> >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
>>> >> >>         st
>>> >> >>         able.git git bisect v3.4.1 v3.4
>>> >> >>
>>> >> >> and test if the kernel that is checked out then results in a
>>> >> >> freeze.
>>> >> >>
>>> >> >> Depending on the test result either do:
>>> >> >>         git bisect good # i.e. problem doesn't occur
>>> >> >>
>>> >> >> or
>>> >> >>
>>> >> >>         git bisect bad # problem is reproducible
>>> >> >>
>>> >> >> Repeat that until git points out the first bad commit and report
>>> >> >> that.
>>> >> >>
>>> >> >> Best regards
>>> >> >> Uwe
>>> >> >>
>>> >> >> --
>>> >> >> Pengutronix e.K.                           | Uwe Kleine-K?nig
>>> >> >>
>>> >> >>   | Industrial Linux Solutions                 |
>>> >> >>
>>> >> >> http://www.pengutronix.de/  |>
>>> >> >
>>> >> > I dont think it has as i have recently been building the latest 3.6
>>> >> > rc
>>> >> > kernels while creating a patch for my nas and i had the same issue's
>>> >> > on them. Thats what prompted me to actualy come to the mailing list
>>> >> > with it. I have tried the 3.6-rc1 and the latest linux-next dated
>>> >> > 17th
>>> >> > of august.
>>> >>
>>> >> Im not sure if this is the right commit as i dont know what way it
>>> >> works but basically the very first commit caused the issue of me not
>>> >> being able to use git and when i typed the git bisect bad it said
>>> >> this:
>>> >>
>>> >> ownerx35 at ownerx35-VirtualBox:~/Desktop/linux$ git bisect bad
>>> >>
>>> >> Bisecting: 21 revisions left to test after this (roughly 5 steps)
>>> >> [774a93aa647f8939867c8ff956847bc63dd51cb3] usbhid: prevent deadlock
>>> >> during timeout
>>> >
>>> > After calling git bisect bad it checks out files from a revision
>>> > between
>>> > the one currently checked and the one marked as good (imagine binary
>>> > search).
>>> >
>>> > You have to compile and test resulting kernels and tell git whether
>>> > they're good or bad until it tells you that it found the problematic
>>> > commit.
>>> >
>>> > Best regards,
>>> > Tomasz Figa
>>> >
>>> >> _______________________________________________
>>> >> linux-arm-kernel mailing list
>>> >> linux-arm-kernel at lists.infradead.org
>>> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> It said something about doing it 5 more times or such. and if im
>>> understanding what your saying basicaly i have to build it 5 more
>>> times then it will tell me the commit that was actualy bad so the one
>>> i said there is not the problematic one?
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> Yes, that's it.
>>
>> P.S. Next time please reply to the mailing list, not to individual posters.
>> I have forwarded your message to the list this time.
>>
>> Best regards,
>> Tomasz Figa
>>
>
> this is odd i went back to the 3.4 kernel (which was working) from my
> earlier testing and which i can wrote to the nand on the device now
> has the same issue with the git clone? I tried the command just to
> make sure the kernel was working and nothing the nas just stopped like
> usual and after 3 rebuild of the kernel its still the same run the
> command and freeze.

I think it seems that there is something bigger than the kernel
causing the git problem
i just decided out of curiosity to recompile a fresh 3.3.7 kernel
which has been working
perfectly and now git clone hangs the nas after being issued so
perhaps its the compiler
or OS that im compileing the kernels on perhaps something has gone wrong there.

incase anyone wants to know im using ubuntu 11.10 in a virtual box vm. with
the codesourcery arm toolchain dated 2012-03.
