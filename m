From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 14 Sep 2012 09:08:26 +0200
Subject: [Query] Does u-boot processes dtb file
In-Reply-To: <CAKohpomkgk_hNAwqseAvc_cyLH+Vtr63r_hJGxsKueZhKno8_A@mail.gmail.com>
References: <CAKohpomkgk_hNAwqseAvc_cyLH+Vtr63r_hJGxsKueZhKno8_A@mail.gmail.com>
Message-ID: <5052D7EA.30902@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.09.2012 08:58, Viresh Kumar wrote:
> Hi Arnd,
> 
> 
> Sorry for the stupid question, but somebody asked this to me and i wasn't sure
> about it.
> 
> We boot with dtb from u-boot using following command:
> bootm <uImage addr> <initrd addr> <dtb addr>
> 
> Does u-boot do anything special or simply passes address of dtb in r2 to kernel?
> 
> i.e. if i do bootm <uImage addr> and stop my kernel early using a debugger,
> update r2 with dtb address, will it work the same way?
> 
> OR
> 
> Does any bootloader needs some special code for handling dtb's?

Working with U-Boot, to my understanding U-Boot modifies ('patches') the 
dtb read from the boot device before passing it to the kernel. It e.g. 
adds the kernel command line and the memory size you specify in U-Boot 
to the dtb.

Best regards

Dirk
