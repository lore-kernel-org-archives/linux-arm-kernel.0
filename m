From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 29 Jun 2018 18:36:10 +0200
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180629110709.GA17859@arm.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com>
Message-ID: <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 1:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> It might not seen sensible, but we could still be relying on this in the
> kernel and so this change would introduce a regression. I think we need
> a way to identify such pointer usage before these patches can seriously be
> considered for mainline inclusion.

Another point that I have here is that KHWASAN is a debugging tool not
meant to be used in production. We're not trying to change the ABI or
something like that (referring to the other HWASAN patchset). We can
fix up the non obvious places where untagging is needed in a case by
case basis with additional patches when testing reveals it.
