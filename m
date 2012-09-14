From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 14 Sep 2012 09:35:30 +0200
Subject: [Query] Does u-boot processes dtb file
In-Reply-To: <CAKohpomubFQMj2uoP+Pb1xBsO7B14W3nR1ddSQ-ajRERNBQ+kg@mail.gmail.com>
References: <CAKohpomkgk_hNAwqseAvc_cyLH+Vtr63r_hJGxsKueZhKno8_A@mail.gmail.com>	<5052D7EA.30902@de.bosch.com>
 <CAKohpomubFQMj2uoP+Pb1xBsO7B14W3nR1ddSQ-ajRERNBQ+kg@mail.gmail.com>
Message-ID: <5052DE42.6080109@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2012 09:16, Viresh Kumar wrote:
> On 14 September 2012 12:38, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> Working with U-Boot, to my understanding U-Boot modifies ('patches') the dtb
>> read from the boot device before passing it to the kernel. It e.g. adds the
>> kernel command line and the memory size you specify in U-Boot to the dtb.
> 
> Thanks for your response.
> 
> But, if this information is also embedded in the dts earlier, will my workaround
> of filling r2 work?

I think so, but I never tried it. It's on my todo list to try this ;) If 
you add all the information needed in the dts file and the resulting dtb 
file is identical to the 'patched' dtb U-Boot passes to the kernel, 
there should be no difference (?).

> Is filling bootargs and memory size the only stuff or some other things too?

I'm not totally sure on this. You could debug this: (a) Take the dtb 
file from your boot device. (b) dump the dtb file U-Boot passes to the 
kernel (i.e. do a memory dump from the pointer U-Boot passes in r2). 
Compare (a) and (b) with a binary diff.

Best regards

Dirk
