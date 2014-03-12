From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Mar 2014 09:44:04 -0600
Subject: CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and bcm2835_defconfig
In-Reply-To: <20140312110315.GG21483@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.10.1403101717050.31525@vincent-weaver-1.um.maine.edu>
 <531FE40C.1060709@wwwdotorg.org>
 <20140312110315.GG21483@n2100.arm.linux.org.uk>
Message-ID: <532080C4.2000801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2014 05:03 AM, Russell King - ARM Linux wrote:
> On Tue, Mar 11, 2014 at 10:35:24PM -0600, Stephen Warren wrote:
>> Hmm. I thought that ARMv6 didn't have efficient unaligned accesses, but
>> I suppose it must; ARM selects HAVE_EFFICIENT_UNALIGNED_ACCESS for
>> v6/v6k/v7. BUILTIN_BSWAP seems innocuous. Can you verify which of those
>> two options actually causes problems for you?
> 
> What do you think is different between v6 and v7 for unaligned accesses?

I don't know the details of unaligned accesses; I'm just remembering
(probably incorrectly and/or misinterpreting) some discussion in U-Boot
about ARMv7 being able to do unaligned accesses OK, yet earlier
generations not being able to (although I don't recall which), and hence
the toolchain options are set up to disallow them, and the ARMv7(?)
config bit that enables them is left disabled, so such accesses cause an
exception, so it's easy to catch the problems that must happen on older
HW even when running on newer HW, even though such access could be
allows on ARMv7.
