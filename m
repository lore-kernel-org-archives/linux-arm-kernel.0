From: stefan.roese@gmail.com (Stefan Roese)
Date: Fri, 14 Sep 2012 11:16:14 +0200
Subject: [Query] Does u-boot processes dtb file
In-Reply-To: <5052DE42.6080109@de.bosch.com>
References: <CAKohpomkgk_hNAwqseAvc_cyLH+Vtr63r_hJGxsKueZhKno8_A@mail.gmail.com>	<5052D7EA.30902@de.bosch.com>
 <CAKohpomubFQMj2uoP+Pb1xBsO7B14W3nR1ddSQ-ajRERNBQ+kg@mail.gmail.com>
 <5052DE42.6080109@de.bosch.com>
Message-ID: <5052F5DE.3010102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2012 09:35 AM, Dirk Behme wrote:
> On 14.09.2012 09:16, Viresh Kumar wrote:
>> On 14 September 2012 12:38, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>>> Working with U-Boot, to my understanding U-Boot modifies ('patches') the dtb
>>> read from the boot device before passing it to the kernel. It e.g. adds the
>>> kernel command line and the memory size you specify in U-Boot to the dtb.
>>
>> Thanks for your response.
>>
>> But, if this information is also embedded in the dts earlier, will my workaround
>> of filling r2 work?
> 
> I think so, but I never tried it. It's on my todo list to try this ;) If 
> you add all the information needed in the dts file and the resulting dtb 
> file is identical to the 'patched' dtb U-Boot passes to the kernel, 
> there should be no difference (?).

Yes, this should work. As a matter of fact, we are using this
pre-patched dtb method for booting directly from the SPL U-Boot version
(small, limited U-Boot version) into the Linux kernel (skipping the
full-blown U-Boot with the dtb patching upon bootm).

>> Is filling bootargs and memory size the only stuff or some other things too?
> 
> I'm not totally sure on this. You could debug this: (a) Take the dtb 
> file from your boot device. (b) dump the dtb file U-Boot passes to the 
> kernel (i.e. do a memory dump from the pointer U-Boot passes in r2). 
> Compare (a) and (b) with a binary diff.

The DT properties that are "patched" differ from platform to platform.
Some also insert dynamically detected clock speeds. Also the board
specific MAC address is often inserted into the dtb. But for basic
kernel bootup, memsize and bootargs are definitely the most important ones.

You could also use U-Boot on the board (if available) to prepare/patch
the dtb via the "fdt" commands. If you have questions on this, please
ask on the u-boot list.

Cheers,
Stefan
