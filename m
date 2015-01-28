From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 28 Jan 2015 22:00:39 +0100
Subject: arm64: USB_ARCH_HAS_EHCI
In-Reply-To: <alpine.DEB.2.02.1501281621330.19947@utopia.booyaka.com>
References: <1422351833.14015.20.camel@x220>
 <alpine.DEB.2.02.1501272130470.19947@utopia.booyaka.com>
 <1422438405.5666.16.camel@x220>
 <alpine.DEB.2.02.1501281621330.19947@utopia.booyaka.com>
Message-ID: <1422478839.3621.34.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, 2015-01-28 at 16:25 +0000, Paul Walmsley wrote:
> Is the Kconfig checker script you mentioned on Tuesday available in the 
> mainline tree?  I don't see anything obvious under the "Static Analysers" 
> section of the Makefile, but perhaps I'm overlooking it.

No, it's not.

In tree you'll find scripts/checkkconfigsymbols.py. That catches over
90% of the stuff my local script catches, in less than 10% of runtime.
It would certainly have caught your use of USB_ARCH_HAS_EHCI.

My local script is my third (or fourth) attempt at a script that checks
these kind of issues. I've used it on linux-next since for about 3/4 of
a year now. While doing that I ran into people that are planning into
adding similar, but far more advanced, functionality into one of the
bots that is checking linux. So I never bothered making my script
public. (I'm not sure what the status of those plan is now.)

In the mean time I'll keep on checking linux-next with my script. That
should also help to see what problems an actual bot could run into, for
the benefit of those people. Problems like:
- should it check each commit (I think it should only check releases);
- should it be a true bot (I think it needs a wetware frontend to
  filter out non-issues).

Hope this answers your question.


Paul Bolle
