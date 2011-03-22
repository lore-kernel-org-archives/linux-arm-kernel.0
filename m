From: schen@mvista.com (Steve Chen)
Date: Tue, 22 Mar 2011 07:21:10 -0500
Subject: [Q] Booting kernel from NFS?
In-Reply-To: <20110322112118.GD5456@radix50.net>
References: <201008080921466561614@gmail.com> <201103201612142509289@gmail.com>
	<20110322112118.GD5456@radix50.net>
Message-ID: <AANLkTim5FOQaFp+SfAFu8vuwYenA6W7J0yoGoXvu5TwT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 6:21 AM, Baurzhan Ismagulov <ibr@radix50.net> wrote:
> On Sun, Mar 20, 2011 at 04:13:04PM +0800, Chen Wenjie wrote:
>> ? ? ? I am debuging some issues on an arm-arch board.
>> now, I have to compile the whole kernel, download zImage to the target board
>> and reboot the board again and again. Since the relations between the
>> source files are complex, it is difficult to just write a module for insmod/rmmod.
>>
>> ? ? ? My question is: is there any way to boot the kernel from NFS? so we can
>> use zImage on the host machine through an ethernet/USB cable. Then we needn't
>> download the zImage file to the target board when we debug it.
>>
>> ? ? ? Is there any bootloader with this feature? Any comments?
>> (now I use bootloader LK("Little Kernel"))
>
> U-Boot can download the kernel over TFTP.

Yes, you can use the tftp or bootp command under u-boot.  Use "help
<command>" for syntax.  Alternatively, you can edit /etc/dhcpd.conf on
the host machine and restart dhcp server to load the kernel
automatically.

Regards,

Steve
