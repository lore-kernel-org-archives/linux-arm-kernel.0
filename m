From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Mar 2015 16:43:53 +0000
Subject: [RFC PATCH 0/3] arm64: relocatable kernel proof of concept
In-Reply-To: <CAKv+Gu8H61BSh6j7jd-MYXh6jS=ePPTj11L5Rs-Ce923te6mUg@mail.gmail.com>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAGXu5jJB8jQm+FOqwWLaA1zYsVYs4gMrgmdUH1LUxnoOcZdDrw@mail.gmail.com>
 <CAKv+Gu_A=_d+2=25WCOhAZnxTHQAWY4QZ2eVgyu03aweJvKjPQ@mail.gmail.com>
 <20150317163554.GM23340@leverpostej>
 <CAKv+Gu8H61BSh6j7jd-MYXh6jS=ePPTj11L5Rs-Ce923te6mUg@mail.gmail.com>
Message-ID: <20150317164353.GN23340@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Also, if you use DEBUG_RODATA the kernel won't be mapped with 1GB
> > mappings after early boot anyway.
> >
> 
> That's not the point. The point is that, since physical memory starts
> at the base of the kernel image, as far as the kernel is concerned,
> the relative alignment of the virtual and physical address spaces may
> result in *all* of memory being mapped using 2 MB sections rather than
> 1 GB blocks.

Ah. Good point.

Another reason to split the text and linear mappings ;)

Mark.
