From: abhijitnaik27@gmail.com (abhijit)
Date: Tue, 10 Apr 2018 17:00:58 +0530
Subject: A200 driver submission for Linux mainline kernel
In-Reply-To: <1523351503.4981.1.camel@pengutronix.de>
References: <01f5f95e-d957-bc32-b8a8-94784523d095@gmail.com>
 <1523351503.4981.1.camel@pengutronix.de>
Message-ID: <d5c4c679-d87c-eb45-c8c3-bdefc7670b30@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

Thank you very much for reply.

The driver is already integrated with new kernel frame-work and tested 
with 4.14.1 kernel with KGSL interface.

There are some patches for MESA and libdrm patches though

I am planning for pushing MESA and DRM patches later. Are you implying 
to push MESA and libdrm specific changes first?

Regards,

 ? Abhijit


On Tuesday 10 April 2018 02:41 PM, Lucas Stach wrote:
> Hi Abhijit,
>
> Am Dienstag, den 10.04.2018, 13:28 +0530 schrieb abhijit:
>> Hi All,
>>
>> I have tested A200/Z430 3D driver for Freescale IMX535/537 SoC by using
>> port from freedreno. I wanted to submit driver patch to linux 4.14.1 for
>> mainlining A200 driver support
>>
>> Currently w.r.t 4.14.1 kernel, the patch has, 109 files changes, 279170
>> insertions, 60 deletions
>>
>> Major part of the code is taken from A200 support from Freescale Linux
>> (2.6.35,
>> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/?h=imx_2.6.35)
>>
>> My question was, can I submit the patch for Linux 4.14.1 kernel for
>> mainlining purpose instead of linux-next?
>>
>> Please point me to any case-study where such huge enhancements were
>> mainlined in the past.
>>
>> Any suggestions for optimizing the mainlining process?
> The downstream driver will not be acceptable to mainline. It's not just
> the size of the driver itself, but it's just full of cruft and doesn't
> integrate with any of the modern kernel frameworks.
>
> If you are going to mainline this driver, it likely needs a full
> rewrite as a proper DRM driver, with a userspace interface sanctioned
> by the Linux DRM community.
>
> Regards,
> Lucas
