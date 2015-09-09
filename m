From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 9 Sep 2015 19:27:43 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <20150909182246.GA1491@leverpostej>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com> <20150909182246.GA1491@leverpostej>
Message-ID: <55F07A1F.3030809@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/15 19:22, Mark Rutland wrote:
> On Wed, Sep 09, 2015 at 06:21:11PM +0100, Julien Grall wrote:
>> The bisector pointed me to this patch. When I disable
>> CONFIG_ARM64_HW_AFDBM, I'm able to boot the kernel and use it
>> without any issue.
> 
> Is the failure identical each time (e.g. is it always in the same
> location)?

Yes, the failure and the stack trace is identical every time. It's
occurring quickly after the userspace is starting.

Note that I was able to reproduce the problem on baremetal too.

I didn't know it when I send the first email as I was hunting down
another issue while booting linux/master on baremetal on xgene.

Regards,

-- 
Julien Grall
