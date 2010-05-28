From: fachkar.datawind@gmail.com (f. achkar)
Date: Fri, 28 May 2010 09:35:20 -0400
Subject: [Solved] Re: [Openocd-development] debugging linux kernel on arm926ejs
	targetvia openocd-0.4.0
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE08E055C848@Cloud.RL.local>
References: <70E876B0EA86DD4BAF101844BC814DFE08E055C848@Cloud.RL.local>
Message-ID: <4BFFC698.8080207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

many thanks to everyone ...
-----------------------------------------------------------
On 05/27/2010 11:56 PM, Jon Povey wrote:
> f. achkar wrote:
>   
>> is there a good reference on how to properly debug the linux kernel
>> via openocd/gdb for an arm target on a linux hot machine?
>>     
> I have been debugging with this kind of setup over the past few days.
> I don't think you can just load your image like you are doing: it is loading at 0xc... which is a virtual address and the MMU hasn't been setup yet.
>
> Instead try doing your steps 1-6 but instead of "load" do:
>  hbreak start_kernel
>  cont
>
> then in u-boot boot the kernel from uImage over TFTP or from flash. Your debugger will break near the start of kernel execution and you can debug from there using software breakpoints (MMU will be on).
>
> If you need to debug the early stuff before MMU is on try
>  hbreak 0x80008000
> instead of start_kernel and have a look at
>  arm-none-linux-gnueabi objdump -S arch/arm/boot/compressed/head.o
>
> --
> Jon Povey
> jon.povey at racelogic.co.uk
>
> Racelogic is a limited company registered in England. Registered number 2743719 .
> Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .
>
> The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
>
>
>   
