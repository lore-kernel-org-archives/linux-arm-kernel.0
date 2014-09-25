From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 25 Sep 2014 22:18:55 +0100
Subject: [PATCH 7/7] efi_rtc: probe function error out in case no efi
 runtime enabled
In-Reply-To: <1411403609.25340.55.camel@deneb.redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
 <1408007953-15151-1-git-send-email-dyoung@redhat.com>
 <1411403609.25340.55.camel@deneb.redhat.com>
Message-ID: <20140925211855.GS18635@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Sep, at 12:33:29PM, Mark Salter wrote:
> 
> Is this still needed after commit da167ad7638759:
> 
>   rtc: ia64: allow other architectures to use EFI RTC

Umm... we should really look at disabling this for x86, since the EFI
time functions don't work on a bunch of machines I've got here.

And it looks like someone enabled this driver and triggered an oops on
their 32-bit EFI tablet,

  https://bugzilla.kernel.org/show_bug.cgi?id=84241#c21
