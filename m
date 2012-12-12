From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Dec 2012 17:28:36 -0800
Subject: Errata on multiplatform kernels
In-Reply-To: <50C7D562.9090706@jonmasters.org>
References: <1355203223.16750.2.camel@gitbox>
 <CAOesGMjJ=y4J70CaYYaEem0ni7Vb48KuEZKxaVYuCCCoMYwjPw@mail.gmail.com>
 <20121211180138.GB4989@atomide.com>
 <50C7D2AE.7050301@jonmasters.org> <50C7D562.9090706@jonmasters.org>
Message-ID: <20121212012836.GC4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Masters <jonathan@jonmasters.org> [121211 16:59]:
> And for the (Google) record, if you see an imprecise external abort at
> boot time on recent multiplatform kernel:
> 
> [   22.141268] Unhandled fault: imprecise external abort (0xc06) at
> 0x4cb2e830
> 
> This may well be that your kernel is running in non-secure mode and does
> not have access to undocumented/unexposed registers that it is trying to
> write into, and consequently is causing this error. There. That should
> save some other poor sucker many wasted hours. Could this, perhaps,
> sometime be documented somewhere? :)

Hmm how about we add a handler for that that would just set the
booted CPU to have non-secure flag set for other code to use?
That is assuming it's the same abort for all ARMs..

Tony
