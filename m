From: eric.miao@linaro.org (Eric Miao)
Date: Wed, 10 Aug 2011 00:28:27 +0800
Subject: Building failure of 3.1-rc1 of drivers/usb/host/ehci-mxc.c
In-Reply-To: <20110809161831.GA4419@freescale.com>
References: <CAMPhdO_yMC5w43A9xC7AsKO2razX1d2VVPtMp5Pm=wb6eFUYRw@mail.gmail.com>
	<20110809161831.GA4419@freescale.com>
Message-ID: <CAMPhdO_8+5pSbFO-1BGKQQDh+61sNANnpXy_JmqtdeL8X2-D4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

That patch looks good. Anyway - we'll eventually get rid of this when
moving to DT.

- eric

On Wed, Aug 10, 2011 at 12:18 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Tue, Aug 09, 2011 at 11:58:05PM +0800, Eric Miao wrote:
>> Hi Sascha,
>>
>> Found the error below when trying to build 3.1-rc1 for imx51/53:
>>
>> In file included from
>> /home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-hcd.c:1190:0:
>> /home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c: In function
>> ?ehci_mxc_drv_probe?:
>> /home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c:175:2:
>> error: implicit declaration of function ?cpu_is_mx35?
>> /home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c:175:2:
>> error: implicit declaration of function ?cpu_is_mx25?
>> /home/ycmiao/linaro/linux-2.6/drivers/usb/host/ehci-mxc.c:185:2:
>> error: implicit declaration of function ?cpu_is_mx51?
>> make[4]: *** [drivers/usb/host/ehci-hcd.o] Error 1
>> make[3]: *** [drivers/usb/host] Error 2
>> make[2]: *** [drivers/usb] Error 2
>> make[1]: *** [drivers] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>>
> The failure has been there for a while. ?I posted a fix[1] there, and
> Greg Kroah-Hartman has queued it up on his branch:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git usb-linus
>
> [1] http://permalink.gmane.org/gmane.linux.usb.general/49793
>
> --
> Regards,
> Shawn
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
