From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 16 Oct 2015 23:53:04 -0700
Subject: [PATCH v7 04/20] of: add function to allow probing a device from
 a OF node
In-Reply-To: <1443517859-30376-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443517859-30376-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20151017065304.GB18329@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 11:10:42AM +0200, Tomeu Vizoso wrote:
> Walks the OF tree up and finds the closest ancestor that has a struct
> device associated with it, probing it if isn't bound to a driver yet.
> 
> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a device should cause its descendants
> to be probed as well (when they get registered).
> 
> Subsystems can use this when looking up resources for drivers, to reduce
> the chances of deferred probes because of the probing order of devices.

How do subsystems know to do this?  Under what situation?  Why is this a
of-only type thing?  Why don't other busses need this?

I don't like to special-case a single bus like this at all if
possible...

thanks,

greg k-h
