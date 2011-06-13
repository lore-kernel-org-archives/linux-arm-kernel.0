From: thiago.correa@gmail.com (=?ISO-8859-1?Q?Thiago_A=2E_Corr=EAa?=)
Date: Mon, 13 Jun 2011 09:04:39 -0300
Subject: linux2.6.35 porting on S3C2416 (USB Host controller driver is not
	comming Up.)
In-Reply-To: <loom.20110613T091605-51@post.gmane.org>
References: <loom.20110613T091605-51@post.gmane.org>
Message-ID: <BANLkTinUSjcju4Oaghf2EJP6-VezkBVmvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ravi,

     I'm also using this board, with kernel 2.6.38, but I'm stuck with
the LAN9221 driver. I haven't tried to use the USB interface yet, but
I do see my kernel detecting the USB host system in the boot messages.
The CD image I got with the kit had an ancient 2.6.2x based kernel, do
you have any newer one?

Kind Regards,
    Thiago A. Correa


On Mon, Jun 13, 2011 at 6:30 AM, Ravi <ratheendran.s@gmail.com> wrote:
> Dear All,
>
> I am trying to port linux-2.6.35.12 on s3c2416 based board(kit2416).I was
> sucessfully able to port kernal,device driver for watchdog,RTC,serialport,LCD
> and NAND flash(256MB).
>
> I followed these steps to call these device at boot time.
>
> Include 's3c_device_ohci' in smdk2416_devices structure.
> a. static struct platform_device *smdk2416_devices[] __initdata = {
> ? ? ? ?&s3c_device_i2c0,
> ? ? ? ?&s3c_device_lcd, //s3c_device_lcd,
> ? ? ? ?&s3c_device_rtc,
> ? ? ? ?&s3c_device_adc,
> ? ? ? ?&s3c_device_iis,
> ? ? ? ?&s3c_device_usbgadget,
> ? ? ? ?&s3c_device_ohci, //USB related config
> ? ? ? ?//&s3c_device_usb,
> ? ? ? ?&s3c_device_hsmmc1,
> ? ? ? ?&s3c_device_smc911x,
> };
> 2. in kernel menuconfig
> ? ?[*] USB support ?--->
> ? ?[*] ? ? OHCI HCD support
>
> 3.menu "S3C2416 Machines"
> ?config MACH_SMDK2416
> ? ? ? ?bool "SMDK2416"
> ? ? ? ?select CPU_S3C2416
> ? ? ? ?select S3C_DEV_FB
> ? ? ? ?select S3C_DEV_HSMMC
> ? ? ? ?select S3C_DEV_HSMMC1
> ? ? ? ?select MACH_SMDK #essl_patch
> ? ? ? ?select S3C_DEV_NAND #essl_patch
> ? ? ? ?select S3C_DEV_USB_HOST ?# essl_patch
>
>
> For the above config I am not able to call the driver of USB HOST Controller
> Interface.
>
>
> Ravi
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
