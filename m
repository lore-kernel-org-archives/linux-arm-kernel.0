From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 30 May 2012 11:01:57 +0800
Subject: [PATCH v4 6/6] pinctrl: add pinctrl gpio binding support
In-Reply-To: <4FC24AA7.9040100@wwwdotorg.org>
References: <1337952980-14621-1-git-send-email-b29396@freescale.com>
 <1337952980-14621-6-git-send-email-b29396@freescale.com>
 <4FBFBB74.901@wwwdotorg.org>
 <CAA+hA=QMe6Yo2aLMBcbkYLDXSagb9L919hjdQaq8TyH4uKh9Mw@mail.gmail.com>
 <4FC24AA7.9040100@wwwdotorg.org>
Message-ID: <20120530030157.GA2235@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 27, 2012 at 09:39:19AM -0600, Stephen Warren wrote:
> On 05/26/2012 10:52 AM, Dong Aisheng wrote:
> > On Fri, May 25, 2012 at 10:03 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 05/25/2012 07:36 AM, Dong Aisheng wrote:
> ...
> >> If we don't do that, [lock ranges[i].gc] I would argue that we
> >> shouldn't store ranges[i].gc, since it might become invalid - I
> >> believe the only use of it is withinthis function?
> >>
> > In my option, i think it's ok to store it since they're just some data
> > to describe
> > hw properties. The gpio function may become invalid but not data.
> > Is it reasonable to you?
> 
> The problem is that if someone tries to dereference the gc field, and
> it's no longer valid, which could cause an OOPS. Perhaps we can get away
> just with a comment in the struct definition indicating that this field
> should only be used by drivers that provided the gc field directly
> rather than having it set up by DT, but then why even store it when
> creating the ranges from DT in that case?
Yes, you're right.
Maybe we could both not store the gc filed for DT (currently we did not see
the need to store it for dt, right?) and add a comment in the struct definition
as you said. For non-dt users the driver owner should manage that field
correctly with lock since it's provided directly by driver.
Is that ok?

Regards
Dong Aisheng
