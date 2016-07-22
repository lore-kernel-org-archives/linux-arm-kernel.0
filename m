From: jeremy.kerr@au1.ibm.com (Jeremy Kerr)
Date: Fri, 22 Jul 2016 08:53:41 +0800
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <4197460.etrDupniY8@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <3489461.zQnV5C1bXR@wuerfel> <1808359.GMbkTHC4O6@hactar>
 <4197460.etrDupniY8@hactar>
Message-ID: <7619c6f9-689e-f062-08d4-0d11a2df66ad@au.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thiago,

> So even if not ideal, the solution above is desirable for powerpc. We would 
> like to preserve the ability of allowing userspace to pass parameters to the 
> OS via the DTB, even if secure boot is enabled.
> 
> I would like to turn the above into a proposal:
> 
> Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
> accepting a complete DTB from userspace, the syscall accepts a DTB 
> containing only a /chosen node. If the DTB contains any other node, the 
> syscall fails with EINVAL. If the DTB contains any subnode in /chosen, or if 
> there's a compatible or device_type property in /chosen, the syscall fails 
> with EINVAL as well.

This works for me. We could even have it as just a DTB fragment that is
merged *at* the /chosen/ node of the kernel-device tree - so would not
contain a /chosen node itself, and it would be impossible to provide
nodes outside of /chosen. Either is fine.

Thanks!


Jeremy
