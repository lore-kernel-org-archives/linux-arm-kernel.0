From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu, 08 Sep 2016 12:23:13 -0300
Subject: Kexec regression in next-20160906
In-Reply-To: <20160907080807.GD5783@n2100.arm.linux.org.uk>
References: <20160906220936.4txqzodkgknhjiyh@atomide.com>
 <2229914.bQjEFCIRgO@hactar> <20160907080807.GD5783@n2100.arm.linux.org.uk>
Message-ID: <8729269.3rIvqbaU1r@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 07 September 2016, 09:08:07 schrieb Russell King - ARM Linux:
> Any change to a UAPI header needs to be carefully considered and
> questioned as it is always a potential userspace breakage - and in
> the kernel, we're supposed to be doing our up-most to avoid
> breaking userspace.
> 
> It's not like it was in the old days when we didn't have the UAPI
> seperate - today, we can find these things by looking at the patch
> diffstat and seeing whether any file in "uapi" is touched.  That
> should be the trigger for a really in-depth review of the change.

No UAPI header is touched by this patch series. That is because there are 
two definitions of struct kexec_segment, one in include/linux/kexec.h and 
the other one in include/uapi/linux/kexec.h. My patch changed the former.
I was unaware of the second definition in the latter.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
