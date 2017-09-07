From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 7 Sep 2017 21:37:32 +0200
Subject: [PATCH v2 15/16] dmaengine: bcm-sba-raid: Add debugfs support
In-Reply-To: <20170818052613.GE3053@localhost>
References: <1501583880-32072-1-git-send-email-anup.patel@broadcom.com>
 <1501583880-32072-16-git-send-email-anup.patel@broadcom.com>
 <20170817080142.GC3053@localhost>
 <CAALAos_SXTMms8XmhEC28gxx4qvvr0z3wqQ=o_-BohMpcXwQTw@mail.gmail.com>
 <20170818052613.GE3053@localhost>
Message-ID: <20170907193732.GB11006@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 10:56:13AM +0530, Vinod Koul wrote:
> On Fri, Aug 18, 2017 at 10:33:54AM +0530, Anup Patel wrote:
> > On Thu, Aug 17, 2017 at 1:31 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > > On Tue, Aug 01, 2017 at 04:07:59PM +0530, Anup Patel wrote:
> > > why fail, debugfs should be an optional thingy, why would you want to fail here?
> > 
> > Yes, we are handling the case when debugfs is not available
> > and skipping debugfs gracefully.
> > 
> > If debugfs is available then failure of debugfs_create_dir()
> > should be reported.
> 
> reported yes, bailing out on that err no..

Reported, no.  You should _never_ care about the return value of a
debugfs call.  Never check it, just move on ad keep on going.  It
doesn't matter.

thanks,

greg k-h
