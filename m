From: panand@redhat.com (Pratyush Anand)
Date: Tue, 21 Jun 2016 11:41:28 +0530
Subject: [PATCH 0/2] Simple fix to the ARM kexec tools implementation
In-Reply-To: <20160617194405.GN1041@n2100.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
Message-ID: <20160621061128.GC29309@dhcppc9>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2016:08:44:05 PM, Russell King - ARM Linux wrote:
> This is the "simple" fix for the ARM kexec tools code, which makes
> the code actually do what the comments describe.
> 
> There are two problems:
> 
> 1. When placing the initrd, we do not take account of the 32k offset
>    that is required for the kernel image.
> 
> 2. The code claims to allow the zImage decompressor to expand by a
>    factor of 4, but only allows space for a factor of 3, since the
>    decompressor itself has to fit in this memory space as well.
> 
> Changing the code to follow the comments allows Keystone II to kexec
> with DEBUG_RODATA enabled, at least with the kernel I've been testing
> with.
> 
> This is a stop-gap solution until a better solution can be implemented.

Yes, so until we have proper header for zImage, these patches looks fine to me.
For both of the patches:

Reviewed-by: Pratyush Anand <panand@redhat.com>

> 
>  kexec/arch/arm/kexec-zImage-arm.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
