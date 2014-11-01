From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 01 Nov 2014 01:21:28 +0100
Subject: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered
 during ->probe()
In-Reply-To: <CAPDyKFpjYkBcW4XMO0CmgOiLux9=iw2=DEHkBG9OVZh5T5CgQg@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <20141031000749.GK36444@dtor-ws>
 <CAPDyKFpjYkBcW4XMO0CmgOiLux9=iw2=DEHkBG9OVZh5T5CgQg@mail.gmail.com>
Message-ID: <1760759.EbfNSUWGb7@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 31, 2014 10:23:00 AM Ulf Hansson wrote:
> On 31 October 2014 01:07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Oct 30, 2014 at 01:47:27PM -0700, Kevin Hilman wrote:
> >> Ulf Hansson <ulf.hansson@linaro.org> writes:
> >>
> >> > To sucessfully probe some devices their corresponding PM domains may
> >> > need to be powered.
> >>
> >> Isn't that what pm_runtime_get*() is supposed to be doing?  Why isn't
> >> that working?
> >
> > Also, I do not understand why we placing device into a power domain only
> > when we probe it. Why if I unbind device from its driver (or do not have
> > a driver for it) it disappears from its power domain? To me power domain
> > and having driver bound to a device are 2 orthogonal concepts.
> 
> That's a different discussion, I don't think we want to go there
> within this context.

Why don't we, exactly?

Rafael
