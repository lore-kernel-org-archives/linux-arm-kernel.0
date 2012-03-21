From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 21 Mar 2012 01:01:07 +0100
Subject: [PATCH v8 0/8] Consolidate cpuidle functionality
In-Reply-To: <CAP245DXwhCMOJaspW8SY7jtqsA3d5SK4Ctr+JvS+cw4yHfL-mw@mail.gmail.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <873992zy5u.fsf@ti.com>
 <CAP245DXwhCMOJaspW8SY7jtqsA3d5SK4Ctr+JvS+cw4yHfL-mw@mail.gmail.com>
Message-ID: <201203210101.08361.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 21, 2012, Amit Kucheria wrote:
> On Wed, Mar 21, 2012 at 12:48 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Arnd Bergmann <arnd.bergmann@linaro.org> writes:
> >
> >> On Tuesday 20 March 2012, Robert Lee wrote:
> >>> This patch series moves various functionality duplicated in platform
> >>> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> >>> disabling was removed as it appears that all calls into
> >>> cpuidle_call_idle will have already called local_irq_disable().
> >>>
> >>> These changes have been pulled into linux-next.
> >>>
> >>> Len, Andrew, can a request be made for Linus to pull these changes?
> >>
> >> FWIW, Len seems to be rather inactive on the kernel mailing list right
> >> now and generally not very interested in anything outside of x86 and
> >> acpi. If he doesn't reply in the next few days and Andrew also isn't
> >> interested in handling these patches, I'd suggest you just send the pull
> >> request to Linus, with Len on Cc and explain that you tried to send
> >> them through him but gave up in the end.
> >
> > FWIW, I have not had good luck getting response for proposed core
> > CPUidle changes either:
> >
> >        http://lkml.org/lkml/2011/9/19/374
> >
> > Maybe it's time that drivers/cpuidle gets a maintainer.  With lots of
> > discussions of scheduler changes that affect load estimation, I suspect
> > we're all going to have a bit of CPUidle work to do in the
> > not-so-distant future.
> >
> 
> I don't mean to be piling on to Len here, but Daniel Lezcano too has a
> bunch of clean ups that didn't get any maintainer review for over two
> months. He has now refreshed them for 3.3 and is getting ready to send
> them out again. We (Linaro) expect to be spending a lot of time on
> cpuidle in the future and would be glad to help review, test and
> collect patches into a tree for Linus/Andrew to pull while we wait for
> Len to respond or another maintainer to emerge.

Well, I discussed that before with Arjan and he said he would maintain
CPUidle if Len didn't have the time, but it seems he didn't expect that
there would be a lot of work on it in the near future.

So, I suggest that if neither Len nor Arjan reappear shortly, people can
send CPUidle patches to me.

Thanks,
Rafael
