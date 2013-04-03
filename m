From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 3 Apr 2013 16:14:09 -0700
Subject: [PATCH 2/7] ARM: KVM: fix HYP mapping limitations around zero
In-Reply-To: <1364909115-3810-3-git-send-email-marc.zyngier@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130403231409.GB29227@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:25:10PM +0100, Marc Zyngier wrote:
> The current code for creating HYP mapping doesn't like to wrap
> around zero, which prevents from mapping anything into the last
> page of the virtual address space.
> 
> It doesn't take much effort to remove this limitation, making
> the code more consistent with the rest of the kernel in the process.

This is quite funny, the code used to behave like this, but
reviewers said that this was old fashioned mm-style code that was
unwanted and wrapping around zero should be avoided for all costs :)

In any case, I welcome the familiarity.

-Christoffer
