From: tj@kernel.org (Tejun Heo)
Date: Tue, 5 May 2015 09:18:54 -0400
Subject: [PATCH v3 1/2] libahci: Add support to handle HOST_IRQ_STAT as
 edge trigger latch.
In-Reply-To: <CAOHikRBeM3MYohDgYgbLL1uhZp+Ch4hS+eduDVbx759321=EHg@mail.gmail.com>
References: <1430667220-23477-1-git-send-email-stripathi@apm.com>
 <1430667220-23477-2-git-send-email-stripathi@apm.com>
 <20150504154726.GA1971@htj.duckdns.org>
 <CAOHikRCZimsE+_-6dqTiCT6qRTFLp9VGt6=WHWA_Z86GBn+WRg@mail.gmail.com>
 <20150504182618.GG1971@htj.duckdns.org>
 <CAOHikRBeM3MYohDgYgbLL1uhZp+Ch4hS+eduDVbx759321=EHg@mail.gmail.com>
Message-ID: <20150505131854.GJ1971@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 11:25:14AM +0530, Suman Tripathi wrote:
> Yeah it's very simple. The clearing of irq_stat needs to move up.
> That's it. tried and it worked. Thanks a lot !!
> Just a quick question : Why edge trigger handling is not yet present
> in libahci yet? I mean no one has used it yet ??

Yeah, no other ahci controller uses edge triggered latches.  I think
ahci spec says irq is supposed to be level triggered.

Thanks.

-- 
tejun
