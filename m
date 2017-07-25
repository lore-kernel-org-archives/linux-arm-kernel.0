From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Jul 2017 16:12:20 +0100
Subject: [kernel-hardening] [PATCH 00/11] ARMv8.3 pointer authentication
 userspace support
In-Reply-To: <b28dcd14-7b4c-b4f3-830b-dbd436200df9@huawei.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
 <b28dcd14-7b4c-b4f3-830b-dbd436200df9@huawei.com>
Message-ID: <20170725151220.GB20857@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 10:12:24PM +0800, Li Kun wrote:
> Hi Mark,

Hi,

> Could you please give us some information about the impact to
> performance to help us evaluating the influence to the system?

I'm afraid I don't have any performance details to share, as this series
has been developed and tested using models, and the performance impact
of pointer authentication will be very much dependent on the
microarchitecture.

I have assumed that this shouldn't regress performance on systems
without pointer authentication functionality, but I haven't yet
attempted to verify that.

>From this series, I'd expect the largest cost to be the semi-lazy KVM
context-switch, for guests which are continuously using pointer
authentication.

Thanks,
Mark.
