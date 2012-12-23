From: will.deacon@arm.com (Will Deacon)
Date: Sun, 23 Dec 2012 11:32:39 +0000
Subject: CoreSight framework and drivers
In-Reply-To: <20121221221828.GA2658@pratikp-linux.qualcomm.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <20121219112314.GA26329@mudshark.cambridge.arm.com>
 <50D1F37E.6000804@ti.com>
 <20121219212431.GC23594@pratikp-linux.qualcomm.com>
 <50D34EE5.8090407@ti.com>
 <20121220195127.GA14877@pratikp-linux.qualcomm.com>
 <50D3972E.4030607@ti.com>
 <20121221221828.GA2658@pratikp-linux.qualcomm.com>
Message-ID: <20121223113239.GG16237@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 10:18:28PM +0000, Pratik Patel wrote:
> What user interface do you plan to provide for the CTI? Maybe
> something consistent with other CoreSight components in sysfs to
> allow users to enable, disable, map and unmap ???
> 
> Please let me know your thoughts.

Rather than have your current approach of dev nodes + sysfs config files for
each coresight device, I think it might be better to follow something closer
to ftrace and stick per-device directories under debugfs/coresight/. Then you
can have a pipe file and some config files in the same directory for each
component. You also don't need to do any mapping operations with this (just
post-process the stream directly).

It might also be fun to play with file redirection for sources and sinks, but
that's probably a bit too invasive.

Will
