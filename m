From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Apr 2017 10:26:04 +0100
Subject: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <1491291844.6218.25.camel@infradead.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
 <1491291844.6218.25.camel@infradead.org>
Message-ID: <20170404092604.GB14898@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys, we were supposed to stop discussing this three days ago.

On Tue, Apr 04, 2017 at 09:44:04AM +0200, David Woodhouse wrote:
> On Tue, 2017-04-04 at 16:35 +0900, AKASHI Takahiro wrote:
> > 
> > Because I think that people sometimes use those two interchangeably.
> > So I said I would defer to the maintainers.
> 
> Sometimes they do, yes. Just as sometimes people use "their",
> "they're", and "there" interchangeably.
> 
> Rarely in a professional context, though. And even more rarely when
> their error has already been pointed out to them.
> 
> There are no good reasons to *deliberately* get it wrong.
> 
> I've heard it suggested that 'MiB' would confuse people who have never
> seen it before. And that it was ugly. Those arguments were fairly
> specious when they were first made, and they're even sillier now ? more
> than 20 years since the binary prefixes were introduced.
> 
> The alleged confusion, and the perceived ugliness, are purely due to
> unfamiliarity and will pass.
> 
> The correctness, and the lack of ambiguity, will not.

I think consistency comes into play here. We (arm64) and the rest of the
kernel get this wrong all the time, so if we're going to fix it then we
should look at the wider codebase and I'd rather not do that as part of the
kdump series. Also, why stop at the suffixes? We don't have any occurences
of 'mebibyte' in the kernel sources, but plenty of busted 'megabytes'. A
patch making arm64 consistent could be discussed separately, otherwise kdump
becomes the pedantic ISO guy trying to lead by example, but really everybody
ignores him because it's completely inconsequential and they also know he
went 35 versions without giving a monkey's.

David, since you seem to be the most outraged, fancy sending a patch? ;)

Alternatively, who fancies burning some dictionaries?

Will
