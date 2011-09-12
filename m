From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 12 Sep 2011 19:21:13 +0300
Subject: [PATCH 1/3] iommu/core: add fault reporting mechanism
In-Reply-To: <20110912160252.GE11701@amd.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
	<20110912160252.GE11701@amd.com>
Message-ID: <CAK=WgbZCDsBk+dueKfAX3ewsvqEnVDN+jW_ftW+BDKnayunOwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 7:02 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> I still don't get the need for this. It would make sense to encode
> different types of faults, like page-faults or interrupt-faults.

Right.

> When I read the comment above it sounds more like you want to encode
> different error-levels, like recoverable and unrecoverable error.
> The exact meaning of these values need to be clarified.

Well, we currently only need to say "something bad has happened".

We don't need at this point to tell whether it's a hardware bug,
inconsistent data, missing page-table entries or whatnot, because we
don't expect the user (or the iommu core itself) to do anything about
it. Not that it's not possible though: a valid response one day would
be to fix the page-table or add a missing TLB (depending on the mode
the hardware is configured to) but this is not (yet?) implemented. So
a "general unrecoverable error" is enough at this point, but it's
certainly makes sense to allow drivers to provide additional types of
errors/faults - once they are implemented.

> Please place 'event' before iova when you keep it, and not at the end.
> Then you have 'where' and 'what' of the fault first before the details
> (iova, flags).

Will do.
