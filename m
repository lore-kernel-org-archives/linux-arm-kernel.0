From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Sep 2013 21:30:42 +0100
Subject: [PATCH] ARM: kvm: rename cpu_reset to avoid name clash
In-Reply-To: <CAOesGMhPHaZ7tOshbvU1M87nshTOVqU7-+1AvOmARzKUDN6syw@mail.gmail.com>
References: <1378938461-10835-1-git-send-email-olof@lixom.net>
 <CAOesGMjum0TSyudXiZtXHOGX4R7dBAhjUpoYnwjTcfD1MMpTxw@mail.gmail.com>
 <20130912015002.GO9860@cbox>
 <CAOesGMiGaM=s85iKHPXd9eBiL1vy3SVws+KR0ToxPpZeiisscg@mail.gmail.com>
 <CAMJs5B9NW6cDuG-xwYucP8rONn0MdEtwTm5R2p=aBE4Q3EHNOg@mail.gmail.com>
 <CAOesGMhPHaZ7tOshbvU1M87nshTOVqU7-+1AvOmARzKUDN6syw@mail.gmail.com>
Message-ID: <20130923203042.GY12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 12:59:44PM -0700, Olof Johansson wrote:
> Hi Christoffer,
> 
> On Mon, Sep 16, 2013 at 8:47 PM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On 16 September 2013 19:41, Olof Johansson <olof@lixom.net> wrote:
> >> Hi,
> >>
> >> On Wed, Sep 11, 2013 at 6:50 PM, Christoffer Dall
> >> <christoffer.dall@linaro.org> wrote:
> >>> On Wed, Sep 11, 2013 at 03:39:26PM -0700, Olof Johansson wrote:
> >>>> On Wed, Sep 11, 2013 at 3:27 PM, Olof Johansson <olof@lixom.net> wrote:
> >>>> > cpu_reset is already #defined in <asm/proc-fns.h> as processor.reset,
> >>>> > so it expands here and causes problems.
> >>>> >
> >>>> > Signed-off-by: Olof Johansson <olof@lixom.net>
> >>>>
> >>>> I just noticed this is broken on 3.10 too, so if/when applying feel free to add:
> >>>>
> >>>> Cc: <stable@vger.kernel.org> # 3.10+
> >>>>
> >>> Thanks for the fix, applied.
> >>
> >> I haven't seen this hit linux-next yet?
> >>
> > I was waiting for kvm/next to move to 3.12-rc1 and base the patch for
> > kvm-arm-next off there, but I pushed this to kvm-arm-next now and it
> > should land in linux-next as soon as they update.
> 
> Another week has passed, and -next and mainline are both still broken.
> Can we please see a fix in mainline and -next within the next few
> days?

I'm getting failing builds too, which will only stop once it hits
mainline.
