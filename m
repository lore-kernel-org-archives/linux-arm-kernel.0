From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 10 May 2013 08:23:55 -0700
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <518D07FB.7010606@codethink.co.uk>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081634.43498.arnd@arndb.de>
 <20130508153459.GA17186@kroah.com>
 <518D07FB.7010606@codethink.co.uk>
Message-ID: <20130510152355.GB11227@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 04:45:15PM +0200, Ben Dooks wrote:
> On 08/05/13 17:34, Greg KH wrote:
> >On Wed, May 08, 2013 at 04:34:43PM +0200, Arnd Bergmann wrote:
> >>>+#define ASC_MAJOR		204
> >>>+#define ASC_MINOR_START		40
> >>
> >>I don't know what the current policy is on allocating major/minor numbers,
> >>but I'm sure you cannot just reuse one that is already used.
> >
> >I agree, why are you trying to create a new tty device name?  Can't you
> >use the existing ttyS name and minor number as you will not have any
> >other type of serial device on this system?
> 
> This would be an issue on systems that either accept plug-in cards
> such as PCMCIA/CardBus/PCI or have additional off SoC IO spaces
> where 8250 compatible UARTS could live.

I thought these were set-top box systems that couldn't accept any
plug-in cards or anything else?  This is a SoC, right?

thanks,

greg k-h
