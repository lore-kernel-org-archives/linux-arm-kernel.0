From: ratheendran.s@gmail.com (Ravi)
Date: Mon, 13 Jun 2011 09:30:07 +0000 (UTC)
Subject: linux2.6.35 porting on S3C2416 (USB Host controller driver is not
	comming Up.)
Message-ID: <loom.20110613T091605-51@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

I am trying to port linux-2.6.35.12 on s3c2416 based board(kit2416).I was
sucessfully able to port kernal,device driver for watchdog,RTC,serialport,LCD
and NAND flash(256MB).

I followed these steps to call these device at boot time.

Include 's3c_device_ohci' in smdk2416_devices structure.
a. static struct platform_device *smdk2416_devices[] __initdata = {
	&s3c_device_i2c0, 
	&s3c_device_lcd, //s3c_device_lcd, 
	&s3c_device_rtc,
	&s3c_device_adc,
	&s3c_device_iis,
	&s3c_device_usbgadget,
	&s3c_device_ohci, //USB related config
	//&s3c_device_usb,
	&s3c_device_hsmmc1,
	&s3c_device_smc911x,		
};
2. in kernel menuconfig
    [*] USB support  ---> 
    [*]     OHCI HCD support 

3.menu "S3C2416 Machines"
 config MACH_SMDK2416
        bool "SMDK2416"
        select CPU_S3C2416
        select S3C_DEV_FB
        select S3C_DEV_HSMMC
        select S3C_DEV_HSMMC1
        select MACH_SMDK #essl_patch
        select S3C_DEV_NAND #essl_patch
        select S3C_DEV_USB_HOST  # essl_patch


For the above config I am not able to call the driver of USB HOST Controller
Interface.


Ravi
