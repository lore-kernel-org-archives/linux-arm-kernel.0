From: stephen.gallimore@st.com (Stephen GALLIMORE)
Date: Wed, 8 May 2013 18:10:48 +0200
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <20130508153459.GA17186@kroah.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de> <20130508153459.GA17186@kroah.com>
Message-ID: <A3BF01DB4A606149A4C20C4C4C808F6C3189E576C2@SAFEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
> > > +#define ASC_MAJOR		204
> > > +#define ASC_MINOR_START		40
> > 
> > I don't know what the current policy is on allocating major/minor 
> > numbers, but I'm sure you cannot just reuse one that is already used.

First, our apologies, this issue was raised internally and then got forgotten about, there's always something I guess.
 
> >I agree, why are you trying to create a new tty device name?  Can't you use the existing ttyS name and minor number as you will not have any other type of serial
> >device on this system?

That is an interesting question Greg; I believe it probably stems from historic ST SoCs that had two different types of serial devices, something that is no longer the case. We will review our approach to this again, although we are not sure we can use the existing ttyS major/minor (even if that is an acceptable thing to do) because of the (remote) possibility of someone using a standard PCIe attached serial card.

Regards,
-stephen
