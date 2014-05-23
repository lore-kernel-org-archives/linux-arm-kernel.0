From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 23 May 2014 09:41:52 -0400
Subject: [PATCH RESEND] mmc: dove: fix missing MACH_DOVE dependency
In-Reply-To: <CAPDyKFp7Sf0sdReOyC8V_-F6ozB6Vh8CEbc+R7eoe6H4t-OmYA@mail.gmail.com>
References: <1400522571-10799-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAPDyKFo8CdyDbJEP0GkFTHdzpkyRBZEp-jAyrU4y8qi__zChkA@mail.gmail.com>
 <CAOesGMjyk=n7MyVisfjYze9UuEb7XNv5O+c1Tndc+q1Q=PEetQ@mail.gmail.com>
 <CAPDyKFp7Sf0sdReOyC8V_-F6ozB6Vh8CEbc+R7eoe6H4t-OmYA@mail.gmail.com>
Message-ID: <20140523134152.GA8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 09:40:55AM +0200, Ulf Hansson wrote:
> On 23 May 2014 09:16, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, May 22, 2014 at 2:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 19 May 2014 20:02, Sebastian Hesselbarth
> >> <sebastian.hesselbarth@gmail.com> wrote:
> >>> DT-enabled Dove moved over from ARCH_DOVE in mach-dove to MACH_DOVE in
> >>> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> >>> DT-only MACH_DOVE Kconfig. This slipped through the cracks and now is
> >>> a fix to allow to build Dove's SDHCI driver for mach-mvebu on v3.15-rc.
> >>>
> >>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >>> Acked-by: Jason Cooper <jason@lakedaemon.net>
> >>
> >> Thanks! Picked up for the PR I send to Chris.
> >
> > Ulf, you might consider adding your tree to linux-next if this is
> > going to be a common work flow for you guys.
> 
> That's done already. :-) There are patches which makes this visible in
> the MAINTAINERS as well, queued for 3.16.
> 
> git://git.linaro.org/people/ulf.hansson/mmc.git next
> 
> Though due to merge conflicts, during this release cycle, I didn't
> want to queue any patches besides for the mmci host driver.
> 
> >
> > It's partially up to Chris though, if he's OK with patches going into
> > your branch more or less being guaranteed to make it into his as well.
> >
> 
> Yes, we need to figure out a good work flow when using two separate
> trees. Thanks for bringing this up!

If you have any questions, please ask.  mvebu has been doing this for
several release cycles now, and I'm also doing it for irqchip now.

The biggest rule is that once you sign a tag and send a pull-request for
it, the branch is immutable up to and including that tag.

thx,

Jason.
