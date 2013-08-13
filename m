From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 14 Aug 2013 07:08:23 +1000
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <CAL_JsqJdGXuTmb2kgBwgmRYGs9f92-dsawDXSXjmJW8cwjFVQQ@mail.gmail.com>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com>
 <CAL_JsqJdGXuTmb2kgBwgmRYGs9f92-dsawDXSXjmJW8cwjFVQQ@mail.gmail.com>
Message-ID: <1376428103.4255.15.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-13 at 13:44 -0500, Rob Herring wrote:
> It is up to Rafael if he is willing/able to rebase his tree, but I
> would drop this series until this is sorted out. I think the new
> common function should be and can be generalized to work for powerpc.
> It would need to make reg property optional and pass in the device
> node to the arch specific function.
> 
> A short term solution would be just to make the function "#ifndef
> CONFIG_PPC".

Please, no ifdef's with different signatures. Let's agree on the
prototype first (ie, thread output argument) and make the generic
one weak.

Cheers,
Ben.
