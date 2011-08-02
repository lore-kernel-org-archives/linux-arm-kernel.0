From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 02 Aug 2011 20:04:27 +0200
Subject: kernel debugging (KGDB or JTAG)
In-Reply-To: <op.vzkug7a5yxxkfz@localhost.localdomain>
References: <op.vzkug7a5yxxkfz@localhost.localdomain>
Message-ID: <1543460.s0MdrL8kip@easynote>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On Tuesday 02 of August 2011 at 10:13:45, Jan Pohanka wrote:
> Using j-ling JTAG probe from segger I can't start debug session at all.
> When JLinkGDBServer connects it resets the board and I'm not able to
> resume the execution. I have found e.g. this howto
> http://www.timesys.com/embedded-linux/docs/Debug_Linux_kernel_with_a_JTAG_fr
> om_Segger but as I said it is not working for me.
> 
> Here is the log from JLinkGDBServer
> 
> J-Link connected
> Firmware: J-Link ARM V8 compiled Jul  5 2011 20:48:23
> Hardware: V8.00
> S/N: [...]
> 
> J-Link found 2 JTAG devices, Total IRLen = 8
> JTAG ID: 0x07926121 (ARM9)
> 
> Connected to 127.0.0.1
> Reading all registers
> WARNING: Failed to read cacheable memory @ address 0x00000000
> Read 4 bytes @ address 0x00000000 (Data = 0x00000000)
> Starting target CPU...

It might be irrelevant, but I have successfully used J-Link to debug Linux 
kernel on S3C6410 SoC, containing an ARM1176JZF-s core, using latest beta 
firmware and their GDB server for windows.

The sequence of operations might be important here. I've been doing it in 
following order:
- started GDB server
- powered the board on
- attached GDB client
- issued 'cont' command to proceed to u-boot and continue normal execution

What might be also helpful is to disable all hang checks in kernel debugging 
section, because the kernel would panic with a false positive after pausing 
the operation for some time.

Best regards,
Tom
