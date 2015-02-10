From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 10 Feb 2015 15:36:32 +0800
Subject: [PATCH] xen/arm: allow console=hvc0 to be omitted for guests
In-Reply-To: <alpine.DEB.2.02.1502100648050.29696@kaball.uk.xensource.com>
References: <1422626319-30752-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.DEB.2.02.1502100648050.29696@kaball.uk.xensource.com>
Message-ID: <54D9B500.2010600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 10/02/2015 15:00, Stefano Stabellini wrote:
> On Fri, 30 Jan 2015, Ard Biesheuvel wrote:
>> This patch registers hvc0 as the preferred console if no console
>> has been specified explicitly on the kernel command line.
>>
>> The purpose is to allow platform agnostic kernels and boot images
>> (such as distro installers) to boot in a Xen/ARM domU without the
>> need to modify the command line by hand.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> This applies on top of the patch Julien is cooking up to move the
>> call to xen_guest_init() to an earlier boot stage. This needs to
>> be at least before the call to console_init() in start_kernel()
>> for this patch to do anything meaningful.
>
> This patch looks good but there isn't much point in queuing this up
> without the prerequisite.
>
> Julien, what patch exactly is that? What is the status of it?

Calling xen_guest_init from setup_arch. It's based on a patch you sent 
an year ago (http://osdir.com/ml/linux-kernel/2013-08/msg00675.html)

But I had some issue with the console. The splitting of xen_guest_init 
doesn't work. It seems that we decode the IRQ too early.

I haven't had time to rework it and sent it.

Regards,

-- 
Julien Grall
