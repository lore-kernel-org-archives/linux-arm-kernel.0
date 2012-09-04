From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Sep 2012 11:44:03 +0100
Subject: [PATCH v2 2/2] ARM: delay: add registration mechanism for delay
 timer sources
In-Reply-To: <20120904100750.GC2458@mudshark.cambridge.arm.com>
References: <1346275524-13817-1-git-send-email-will.deacon@arm.com>
 <1346275524-13817-2-git-send-email-will.deacon@arm.com>
 <503FFC7D.9050704@codeaurora.org>
 <20120904100750.GC2458@mudshark.cambridge.arm.com>
Message-ID: <20120904104403.GE2458@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 11:07:50AM +0100, Will Deacon wrote:
> On Fri, Aug 31, 2012 at 12:51:25AM +0100, Stephen Boyd wrote:
> > > +void __init register_current_timer_delay(struct delay_timer *timer)
> > 
> > const?
> 
> Sure. I'll send an updated patch.

Gah, spoke too soon. This isn't going to work, as the frequency may not be
known until probe time (for example, it could be obtained by the device
tree) so const data isn't going to cut it.

Will
