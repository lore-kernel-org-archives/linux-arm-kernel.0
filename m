From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 12 Mar 2010 09:42:33 +0530
Subject: [PATCH 10/11] ST SPEAr: Added default configuration files for
	SPEAr machines
In-Reply-To: <63386a3d1003111218g5799974cv3336ceaa2b3367a9@mail.gmail.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-6-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-7-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-8-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-9-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-10-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-11-git-send-email-viresh.kumar@st.com>
	<63386a3d1003111218g5799974cv3336ceaa2b3367a9@mail.gmail.com>
Message-ID: <4B99BF31.6020102@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/12/2010 1:48 AM, Linus Walleij wrote:
> 2010/3/3 Viresh KUMAR <viresh.kumar@st.com>:
>> (...)
>> +CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> 
> Not specifically related to this defconfig because hundreds of defconfigs
> use this, but HAVE_GENERIC_DMA_COHERENT is not used in anything but
> a few Kconfig files, all just defining it. No single Makefile, #ifdef
> or anything
> else seems to be using this, so what is it for?? I can't find any use even if I
> go back to kernel 2.6.11 on LXR.
> 
>> (...)
>> +#
>> +# Networking options
>> +#
>> +CONFIG_PACKET=y
>> +CONFIG_PACKET_MMAP=y
>> (...)
> 
> You're obviously doing a lot of networking in this system, but the machine
> has no network interfaces defined... yet, I suppose, so if it's coming,
> keep it. (Or are you running PPP over your UART?)
> 
>> +#
>> +# Bluetooth device drivers
>> +#
>> +CONFIG_BT_HCIUART=m
>> +CONFIG_BT_HCIUART_H4=y
>> +CONFIG_BT_HCIUART_BCSP=y
>> (...)
> 
> Same here, make sure you're really going to
> have Bluetooth on this device.
> 
>> +#
>> +# SCSI device support
>> +#
>> +# CONFIG_RAID_ATTRS is not set
>> +CONFIG_SCSI=m
>> +CONFIG_SCSI_DMA=y
> 
> Same issue here.
> 
>> +#
>> +# Userland interfaces
>> +#
>> +CONFIG_INPUT_MOUSEDEV=y
>> +# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>> +CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>> +CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>> +CONFIG_INPUT_JOYDEV=m
>> +CONFIG_INPUT_EVDEV=y
>> +# CONFIG_INPUT_EVBUG is not set
> 
> ...and here
> 
>> +CONFIG_INPUT_TOUCHSCREEN=y
>> +# CONFIG_TOUCHSCREEN_AD7879 is not set
>> +# CONFIG_TOUCHSCREEN_DYNAPRO is not set
>> +# CONFIG_TOUCHSCREEN_FUJITSU is not set
>> +CONFIG_TOUCHSCREEN_GUNZE=m
> 
> Aha OK where is that connected?
> 
>> +CONFIG_EXT3_FS=m
> 
> Good choice, nowadays I think you should even consider EXT4.
> But you have no block device for it in the platform...
> Again I guess it's a runner-up, just checking.
> 
>> +CONFIG_FS_POSIX_ACL=y
> 
> This is rarely used in embedded.
> 
>> +CONFIG_QUOTA=y
> 
> This is also rare in embedded.
> 
>> +#
>> +# CD-ROM/DVD Filesystems
>> +#
>> (...)
>> +#
>> +# DOS/FAT/NT Filesystems
>> +#
> 
> Again there is no corresponding block device for this.
> (Just checkin.)
> 
>> +CONFIG_CRAMFS=m
> 
> Is cramfs really useful as a module?
> Enlighten me.
> 
>> +CONFIG_NETWORK_FILESYSTEMS=y
>> +CONFIG_NFS_FS=m
>> +CONFIG_NFS_V3=y
>> (...)
> 
> On what network interface?
> 
>> +#
>> +# Partition Types
>> +#
>> +CONFIG_PARTITION_ADVANCED=y
>> +# CONFIG_ACORN_PARTITION is not set
>> +CONFIG_OSF_PARTITION=y
>> +# CONFIG_AMIGA_PARTITION is not set
>> +# CONFIG_ATARI_PARTITION is not set
>> +CONFIG_MAC_PARTITION=y
> 
> I doubt that you need these weird partition types.
> 
>> +CONFIG_NLS=y
>> +CONFIG_NLS_DEFAULT="utf8"
>> +CONFIG_NLS_CODEPAGE_437=y
> 
> I usually only keep 437 but if you need the others, sure.
> 
>> +CONFIG_SECURITY_SELINUX=y
> 
> This is some serious stuff to compile into an embedded system,
> make sure you really need it.
> 
>> +#
>> +# Random Number Generation
>> +#
>> +CONFIG_CRYPTO_ANSI_CPRNG=m
>> +CONFIG_CRYPTO_HW=y
> 
> Do you have crypto HW? It's not in the machine right now atleast.
> 
> Comments repeat for the other configs, I just wanna make sure you're
> really gonna use all of this so that your kernel is not too big for no good
> reason.
> 

Linus,

I will remove all unwanted parts from defconfigs.

viresh.
