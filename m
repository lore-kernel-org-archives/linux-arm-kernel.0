From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Oct 2013 11:15:56 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
Message-ID: <20131021091555.GB21518@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 09:00:08PM -0400, Nicolas Pitre wrote:
[...]
> The hardware support in the kernel, on the other hand, can be improved 
> incrementally with time.  It doesn't matter if it is not optimal at 
> first. It can be revisited, optimized, reviewed, and sometimes even 
> redesigned.  And only when it reaches maturity would be the time to use 
> the experience from the kernel development and make some firmware out of 
> it.  But what would be the point then?

I agree. However that's currently no longer the case. We're severely
limiting ourselves because we're requiring DT to be a stable ABI.

A stable ABI means there's about zero chance of redesigning something
after it's been merged. Unless we want to live with having to support
several DT bindings in a driver.

The kind of flexibility and unstable API within the kernel is something
that I've always been very fond of, precisely because it allows us to
get features implemented fairly quickly. At the same time we have the
possibility to redesign code when we have to. It's just impossible to
take into account every possible detail up front simply because we're
all only human and because some things just might change over time. I'm
fairly sure that Linux wouldn't be where it is today if we didn't have
that flexibility.

Right now, we're taking away much of that flexibility and I see progress
on ARM actively hindered.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131021/bca948a4/attachment.sig>
