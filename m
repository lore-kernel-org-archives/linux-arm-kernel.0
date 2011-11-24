From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 24 Nov 2011 11:47:42 +0100
Subject: [AT91 PULL] defconfig pullrequest
In-Reply-To: <201111232115.08556.arnd@arndb.de>
References: <20111102155803.GE7136@game.jcrosoft.org>
 <CAOesGMirB+wWB7D93d7Q9V0+Mt-PAbcaYvio9UJ27T-4zODPzQ@mail.gmail.com>
 <4ECD04AB.7000900@atmel.com> <201111232115.08556.arnd@arndb.de>
Message-ID: <20111124104742.GG15531@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:15 Wed 23 Nov     , Arnd Bergmann wrote:
> On Wednesday 23 November 2011, Nicolas Ferre wrote:
> > On 11/10/2011 02:35 AM, Olof Johansson :
> > > On Wed, Nov 9, 2011 at 5:29 PM, Jean-Christophe PLAGNIOL-VILLARD
> > > <plagnioj@jcrosoft.com> wrote:
> > >> On 01:37 Thu 10 Nov     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > >>> On 08:01 Wed 09 Nov     , Olof Johansson wrote:
> > >>>> Hi,
> > >>>>
> > >>>> On Wed, Nov 9, 2011 at 6:41 AM, Jean-Christophe PLAGNIOL-VILLARD
> > >>>> <plagnioj@jcrosoft.com> wrote:
> > >>>>
> > >>>>>        when do you pull this one?
> > >>>>>
> > >>>>>        can it go to the 3.2?
> > >>>>
> > >>>> Arnd is offline most of this week, so I'll reply.
> > >>>>
> > >>>> The merge window is closed and only bug fixes should be sent upstream
> > >>>> at this time, so this should go into a 3.3-targeted branch now.
> > >>>>
> > >>>> The pull request was sent halfway through the merge window, which to
> > >>>> be strict means that it was already too late. Next time, please make
> > >>>> sure your branches are staged in the arm-soc tree before the window
> > >>>> opens, ideally around -rc6 or -rc7 time frame.
> > >>> the pull was send first before the release of 3.1 originaly it's a resend of
> > >>> the previous one split in 2 pull
> > >>>
> > >>> so was suposed to be merged before
> > >> I forget to mention it but there was an agreement with arnd durring the kernel
> > >> summit to pull the defconfig part and let the gpio go for 3.3
> > > 
> > > Ok. I'll defer to Arnd when he's back next week then!
> > 
> > Arnd, ping?
> 
> Sorry for the delay in replying.
> 
> I looked at
> 
>   git://github.com/at91linux/linux-at91.git j/for-arnd-defconfig
> 
> again, and the changes in there do not match the description, so I'm not
> pulling them like this:
> 
> 1. The series was not rebased to leave out the gpio patches, the HEAD of
> the branch still contains them.
the series does leave the gpio work
it's containt just the work on the usb that was already merged in the tree

the gpio work is  in an other pull request for 3.3
> 
> 2. The patches are described as 'rename ...config to ...config', but they
> actually modify the files as well.
yes as described in the commit the enable all boards at the same time when
it's needed
> 
> 3. There are in fact merge conflicts against 3.2-rc2.
??
> 
> I can still take the changes, but please rebase them. It would also be
> better to split the patches on functional changes, instead of per file,
> and make sure that each patch only does what the description says, like:
> 
> * ARM: at91: enable additional boards in existing defconfig files
> * ARM: at91: refresh defconfig files for 3.2
> * ARM: at91: rename defconfig files appropriately
ok

will send later today

Best Regards,
J.
