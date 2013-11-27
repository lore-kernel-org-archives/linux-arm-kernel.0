From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Nov 2013 11:04:05 +0000
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses
In-Reply-To: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
Message-ID: <5295D1A5.5090403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC-ing the maintainers - seems odd they were not cc-ed the first place]

On 27/11/13 07:34, mohun106 at gmail.com wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> This patch series provides an implementation of supporting 48-bit
> Physical Addresses for ARMv8 platforms. It is the maximum width that
> any ARMv8 based processor can support. 
> 
> The implementation extends the existing support of 40-bit PA.The kernel
> and user space will now be able to access 128TB each. With 4KB page size
> the Linux now will be using 4 levels of page tables by making use of
> 'pud'. And with 64KB page size the Linux will be using 3 levels of page
> tables.
> 
> The code has been tested with LTP.

Aside from finding out whether or not this is a useful change, this
breaks KVM, more specifically the way kernel pages are mapped into HYP.
Also, guests will still be limited to 40-bit IPAs, and the stage-2
output range needs to be addressed as well.

	M.
-- 
Jazz is not dead. It just smells funny...
