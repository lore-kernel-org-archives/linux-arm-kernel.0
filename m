From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 6 Jul 2013 12:36:46 -0700
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <51D674BF.9030207@schinagl.nl>
References: <20130617225847.GA9494@kroah.com> <20130624092942.GG26008@lukather>
 <20130624160440.GA15201@kroah.com> <51C87DC7.50005@schinagl.nl>
 <20130624181509.GA8847@kroah.com> <51C8B84C.3020200@schinagl.nl>
 <20130624214615.GA17604@kroah.com> <51CAA709.4060801@schinagl.nl>
 <20130626175144.GC2222@kroah.com> <51D674BF.9030207@schinagl.nl>
Message-ID: <20130706193646.GB9778@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 09:24:47AM +0200, Oliver Schinagl wrote:
> The other 'broken' drivers that where linked earlier, also use the
> BINARY attributes.
> 
> So Greg, if you could be so kind and give me an example how to
> implement this properly, I am at loss and don't know :(

Ah crap, devices don't have a binary attribute group, like struct class
does.  I'll go add that on Monday and send you the patch to see if that
helps you out.  I'll also go through and fix up all of the binary
attribute drivers to keep them from doing that...

Sorry, I missed that earlier, but thanks for trying and pointing out my
mistake.

greg k-h
