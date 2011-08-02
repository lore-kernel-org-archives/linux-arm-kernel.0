From: xhpohanka@gmail.com (Jan Pohanka)
Date: Tue, 02 Aug 2011 10:13:45 +0200
Subject: kernel debugging (KGDB or JTAG)
Message-ID: <op.vzkug7a5yxxkfz@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

I'd like to ask if anyone has working setup for kernel debugging on arm
target. I have tried two boards (one with at91sam9g20, second with
freescale i.mx27) with Segger j-link and kgdb with similar and not very
useful results. I have Ubuntu 11.04 as development host and latest
codesourcery arm-none-(linux-gnu)eabi toolchain.

Using 2.6.39 I was able to compile the sources with KGDB enabled. I'm also
able to enter kdb terminal and connect with arm-none-eabi-gdb. Setting and
triggering breakpoints works well, but single stepping (which is essential
to me) does not. Here is the example

Breakpoint 1, 0xc00e40d4 in sys_sync () at
/home/honza/_dev/kernel/linux-2.6.39.y/fs/sync.c:190
190	}
(gdb) list
185			ret = err;
186		mutex_unlock(&mapping->host->i_mutex);
187	
188	out:
189		return ret;
190	}
191	EXPORT_SYMBOL(vfs_fsync_range);
192	
193	/**
194	 * vfs_fsync - perform a fsync or fdatasync on a file
(gdb) s
Sending packet: $Hc148#48...Ack
Packet received: OK
Sending packet: $s#73...Ack
Packet received:
warning: Invalid remote reply:

... now gdb hangs forever

Using j-ling JTAG probe from segger I can't start debug session at all.
When JLinkGDBServer connects it resets the board and I'm not able to
resume the execution. I have found e.g. this howto
http://www.timesys.com/embedded-linux/docs/Debug_Linux_kernel_with_a_JTAG_from_Segger
but as I said it is not working for me.

Here is the log from JLinkGDBServer

J-Link connected
Firmware: J-Link ARM V8 compiled Jul  5 2011 20:48:23
Hardware: V8.00
S/N: 58004787

J-Link found 2 JTAG devices, Total IRLen = 8
JTAG ID: 0x07926121 (ARM9)

Connected to 127.0.0.1
Reading all registers
WARNING: Failed to read cacheable memory @ address 0x00000000
Read 4 bytes @ address 0x00000000 (Data = 0x00000000)
Starting target CPU...


Any advice will be greatly appreciated...

with best regards
Jan

-- 
Tato zpr?va byla vytvo?ena p?evratn?m po?tovn?m klientem Opery:
http://www.opera.com/mail/
