From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 25 Sep 2015 22:33:24 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <4331507.W3ZDWldbWu@vostro.rjw.lan>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <20150925185256.GG5951@linux> <4331507.W3ZDWldbWu@vostro.rjw.lan>
Message-ID: <4357538.Wlf88yQie6@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 25, 2015 10:26:22 PM Rafael J. Wysocki wrote:
> On Friday, September 25, 2015 11:52:56 AM Viresh Kumar wrote:
> > On 25-09-15, 20:49, Johannes Berg wrote:
> > > Ok, then, but that means Rafael is completely wrong ...
> > > debugfs_create_bool() takes a *pointer* and it needs to be long-lived,
> > > it can't be on the stack. You also don't get a call when it changes.
> > 
> > Ahh, ofcourse. My bad as well...
> 
> Well, sorry about the wrong suggestion.
> 
> > I think we can change structure definition but will wait for Rafael's
> > comment before that.
> 
> OK, change the structure then.

But here's a question.

You're going to change that into bool in the next patch, right?

So what if bool is a byte and the field is not word-aligned and changing
that byte requires a read-modify-write.  How do we ensure that things remain
consistent in that case?

Thanks,
Rafael
