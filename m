From: snijsure@grid-net.com (Subodh Nijsure)
Date: Fri, 18 May 2012 15:52:18 -0700
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <20120518010138.GA5427@S2101-09.ap.freescale.net>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
Message-ID: <4FB6D2A2.1090400@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2012 06:01 PM, Shawn Guo wrote:
> On Thu, May 17, 2012 at 04:03:43PM -0700, Subodh Nijsure wrote:
>> Should one be able to run top of the linux-next on MX28 EVK hardware
>> with DT support enabled?
> Yes, I'm running it well with next-20120516.

I followed the subsequent discussion on this, looks like most of you are 
booting your kernels with uBoot.
We are using linux_prep bootlets from freescale to boot linux kernel.

I have following options turned on in my setup
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y

I am building imx28-evk.dtb and appending it to zImage as in:

make  imx28-evk.dtb
cat zImage imx28-evk.dtb > zImage_w_dtb

We will investigate this further and let you know what I find, would be 
glad to hear if anybody else is using MXS platform with appended device 
tree.

-Subodh
