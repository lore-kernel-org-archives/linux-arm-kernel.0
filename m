From: greg@kroah.com (Greg KH)
Date: Tue, 13 Mar 2018 14:25:10 +0100
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <CAKv+Gu8ratRYnGzNm5qppUetEFt4Dief_3_Dj6yaW==DJemeHQ@mail.gmail.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
 <20180313100442.GB1999@kroah.com>
 <CAKv+Gu-v6U49_OZyt6HHmCJ7srYnNw040LpVkFnzx+BGKVC0aA@mail.gmail.com>
 <20180313103843.GA29908@kroah.com>
 <CAKv+Gu8ratRYnGzNm5qppUetEFt4Dief_3_Dj6yaW==DJemeHQ@mail.gmail.com>
Message-ID: <20180313132510.GA3629@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 01:01:43PM +0000, Ard Biesheuvel wrote:
> On 13 March 2018 at 10:38, Greg KH <greg@kroah.com> wrote:
> > On Tue, Mar 13, 2018 at 10:13:26AM +0000, Ard Biesheuvel wrote:
> >> On 13 March 2018 at 10:04, Greg KH <greg@kroah.com> wrote:
> >> > On Wed, Mar 07, 2018 at 06:24:09PM +0000, Ard Biesheuvel wrote:
> >> >> On 2 March 2018 at 16:54, Greg KH <greg@kroah.com> wrote:
> ...
> >> >> > Please test on the hardware that is affected, otherwise you do not know
> >> >> > if your patches do anything or not.
> >> >> >
> >> >>
> >> >> I don't think it is feasible to test these backports by confirming
> >> >> that they make the fundamental issue go away. We simply don't have the
> >> >> code to reproduce all the variants, and we have to rely on the
> >> >> information provided by ARM Ltd. regarding which cores are affected
> >> >> and which aren't.
> >> >
> >> > You really don't have the reproducers?  Please work with ARM to resolve
> >> > that, this should not be a non-tested set of patches.  That's really
> >> > worse than no patches at all, as if they were applied, that would
> >> > provide a false-sense of "all is fixed".
> >> >
> >>
> >> I know that on x86, the line between architecture and platform is
> >> blurry. That is not the case on ARM, though.
> >>
> >> Unlike platform firmware, the OS is built on top of an abstracted
> >> platform which is described by ARM's Architecture Reference Manual. If
> >> ARM Ltd. issues recommendations regarding what firmware PSCI methods
> >> to call when doing a context switch, or which barrier instruction to
> >> issue in certain circumstances, they do so because a certain class of
> >> hardware may require it in some cases. It is really not up to me to go
> >> find some exploit code on GitHub, run it before and after applying the
> >> patch and conclude that the problem is fixed. Instead, what I should
> >> do is confirm that the changes result in the recommended actions to be
> >> taken at the appropriate times.
> >
> > To _not_ take that exploit code and run it to _verify_ that your patches
> > work, would be foolish, right?
> >
> 
> Oh, absolutely. But that presupposes access to both the affected
> hardware and the exploit code.

If you all don't have access to both, then someone is doing something
seriously wrong.  Go complain to ARM please, we all know they have both.

I just got done yelling at a whole bunch of vendors last week about this
whole mess at a very large meeting of a lot of different Linux-based
companies.  It's crazy that the disfunction is still happening.

greg k-h
