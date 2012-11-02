From: stigge@antcom.de (Roland Stigge)
Date: Fri, 02 Nov 2012 10:22:22 +0100
Subject: [PATCH RESEND 1/5 v6] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CACxGe6vEr5fd0_ZuzV=nOXVfwA7_FB5L6KJsEwMEHmVj0rDA=g@mail.gmail.com>
References: <1351457210-25222-1-git-send-email-stigge@antcom.de>
 <1351457210-25222-2-git-send-email-stigge@antcom.de>
 <CACxGe6vgryMPygc8SKFLKqP8Wq=pcGiJe_dPCiDC-evzf32UMA@mail.gmail.com>
 <50915DBC.2000802@antcom.de>
 <CACxGe6vEr5fd0_ZuzV=nOXVfwA7_FB5L6KJsEwMEHmVj0rDA=g@mail.gmail.com>
Message-ID: <509390CE.90402@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 07:59 PM, Grant Likely wrote:
>> Pin direction currently needs to be set up separately, analogous to
>> requesting gpios. Need to document this better, right. The assumption is
>> that I/O needs to be efficient primarily, before bloating the API with
>> direction functions. Or should I add functions for this?
> 
> Since this is a userspace facing ABI, once it is merged it cannot be
> changed in an incompatible way. I cannot merge it until there is at
> least a plan for how to handle all of the reasonable use cases. That
> means it must support set/clear or mask operations. Also, if it sticks
> with the design of grouping pins from multiple controllers, then it
> needs to handle explicitly constraining what order operations are
> performed in at the time of the operation. At the time of setup
> doesn't work since constraints between pins may not always be in the
> same order.
> 
> I really think you should consider implementing a command stream type
> of interface.

Yes, understand. What do you consider a good example of a command stream
type interface? Link or hint appreciated!

There was already mentioned the idea of a device node which can be
interfaced to via ioctl() for the various operations. Can it be a
"struct miscdevice" or do you require sth. more sophisticated?

Thanks in advance,

Roland
