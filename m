From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Tue, 17 Oct 2017 12:41:49 +0000
Subject: [PATCH 00/11] KASan for arm
In-Reply-To: <20171011225805.GY20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <26660524-3b0a-c634-e8ce-4ba7e10c055d@gmail.com>
 <bb809843-4fb8-0827-170e-26efde0eb37f@gmail.com>
 <44c86924-930b-3eff-55b8-b02c9060ebe3@gmail.com>
 <4b7b2b3c-cba9-d8ab-72a7-119bd5fae65d@redhat.com>
 <20171011225805.GY20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CAEB@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2017 7:40 PM, Abbott Liu wrote:
>On Wed, Oct 11, 2017 at 03:10:56PM -0700, Laura Abbott wrote:
>The decompressor does not link with the standard C library, so it
>needs to provide implementations of standard C library functionality
>where required.  That means, if we have any memset() users, we need
>to provide the memset() function.
>
>The undef is there to avoid the optimisation we have in asm/string.h
>for __memzero, because we don't want to use __memzero in the
>decompressor.
>
>Whether memset() is required depends on which compression method is
>being used - LZO and LZ4 appear to make direct references to it, but
>the inflate (gzip) decompressor code does not.
>
>What this means is that all supported kernel compression options need
>to be tested.

Thanks for your review. I am sorry that I am so late to reply your email.
I will test all arm kernel compression options.
