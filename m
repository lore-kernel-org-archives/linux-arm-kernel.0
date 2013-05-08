From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 8 May 2013 08:53:01 -0700
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <20130508154057.GB3041@game.jcrosoft.org>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de>
 <20130508153459.GA17186@kroah.com>
 <20130508154057.GB3041@game.jcrosoft.org>
Message-ID: <20130508155301.GB27273@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 05:40:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 08:34 Wed 08 May     , Greg KH wrote:
> > On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
> > > > +#define ASC_MAJOR		204
> > > > +#define ASC_MINOR_START		40
> > > 
> > > I don't know what the current policy is on allocating major/minor numbers,
> > > but I'm sure you cannot just reuse one that is already used.
> > 
> > I agree, why are you trying to create a new tty device name?  Can't you
> > use the existing ttyS name and minor number as you will not have any
> > other type of serial device on this system?
> 
> Greg on ST STB for more than 10 years we use ttyASC I'll prefer ttySx

For 10+ years you have had an out-of-tree serial driver?  What
major/minor numbers did you use for it?

> on the DTB SoC you have one one IP present the st,asc

I don't understand, what do you mean by this?

confused,

greg k-h
