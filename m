From: somshekar@celestialsys.com (Somshekar ChandrashekarKadam)
Date: Mon, 7 Sep 2009 19:37:44 +0530
Subject: No subject
Message-ID: <5af5975c16d54553aca8541160715298@dr116.cyberspaceindia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin Marinas,

I am working on ARM1176 Realview board.
Kernel stable arm 2.6.28

My first query

I think reboot command is not implemented. ?

Work done locally here.

Implemented reboot by setting  8th bit of SYS_RESETCTL (reset control register 0x10000040). It works fine when given command reboot.

Issue Faced

ASLA works fine when done hard poweroff and poweron. ALSA detected properly and works fine.When I do a soft reboot using reboot command.  when kernel boots up it doesn't detect ALSA device itself with the
following messages. It is not able to read AC97 Register failing
because of timeout. I tried increasing the timeout and udelay still the
same case. Messages are shown below a the end.I also tried setting the various depth of a soft reset like 
(1=SYSRST rest logic tile, 2=PLLLOCK reset PLL, 4=PBRESET board reset,
same as pressing reset button). still ALSA does not work.Now I am confused on this. Please throw some light on this or any pointer will be useful.It is not able to read AC97 Register failing
because of timeout. routine (/*
 * Read an AC'97 register.
 */
static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)) 
I hope i have made myself clear. 
Thanks In Advance

Messages when ALSA not detected

====================================================

When sound doesn't work I see following in boot log:

Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 7c)
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 7e)
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 7c)
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 7e)
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 1c)
port 1 high speed
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 7c)
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 7e)
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back (0 != 1c)
usb 1-1: new high speed USB device using isp1760 and address 2
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: ac97 read back fail.  retry
aaci-pl041 fpga:04: wrong ac97 register read back 


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090907/092b9ae9/attachment-0001.htm>
