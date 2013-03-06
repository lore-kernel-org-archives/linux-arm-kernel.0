From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Mar 2013 00:26:15 +0000
Subject: [PATCH] ARM: proc: Add Krait proc info
In-Reply-To: <51366B9E.7010502@codeaurora.org>
References: <1362439299-29617-1-git-send-email-sboyd@codeaurora.org>
 <20130305083421.GA19391@mudshark.cambridge.arm.com>
 <51366B9E.7010502@codeaurora.org>
Message-ID: <20130306002615.GA20530@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 10:03:10PM +0000, Stephen Boyd wrote:
> On 03/05/13 00:34, Will Deacon wrote:
> > I was looking at this the other day and wondered whether we could set
> > HWCAP_IDIV in __v7_setup, depending on ID_ISAR0[27:24]. I can't immediately
> > think why that would be difficult, but similarly there may well be a reason
> > why we assign it like this.
> >
> > Fancy taking a look?
> 
> Ok I'll take a look. Should we be masking out HWCAP_IDIVT on
> !CONFIG_ARM_THUMB configurations?

Yes, that's not a bad idea. It makes the IDIV* caps follow what we do for
the others (vfp etc) by only advertising support if the relevant CONFIG
options are selected.

Will
