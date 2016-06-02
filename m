From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 2 Jun 2016 10:21:53 -0700
Subject: [PATCH 01/32] arm64: Add platform selection for BCM2835.
In-Reply-To: <1464887569.24775.123.camel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-2-git-send-email-kraxel@redhat.com>
 <574F5881.4060008@gmail.com> <1464849936.24775.33.camel@redhat.com>
 <4e72ae37-a018-a17d-6a58-8450db58d1c7@broadcom.com>
 <57506351.3060706@broadcom.com> <1464887569.24775.123.camel@redhat.com>
Message-ID: <57506B31.2010600@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16-06-02 10:12 AM, Gerd Hoffmann wrote:
>> There is no need to add ARCH_BCM though?
>
> There are Makefile(s) with
>
> obj-$(CONFIG_ARCH_BCM)          += bcm/
>
> in drivers/pinctrl for example, maybe more, didn't check the whole tree.
>
> So without ARCH_BCM some drivers are dropped from the build ...

I see that now.  Quite bizarre how the NS2 pinctl driver (used on a 
arm64 SoC) gets built right now....

Yes, adding the select with hidden option seems like what needs to be 
done.  The ARM Maintainers did not like multi-level ARCH_BCM being added 
in the arm64 Kconfig previously so we dropped it.

>
> cheers,
>    Gerd
>
Thanks,
  Scott
