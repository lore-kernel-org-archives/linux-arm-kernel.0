From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Wed, 19 Feb 2014 10:14:05 +0530
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <20140218120249.GD11049@arm.com>
References: <1390908022-10287-1-git-send-email-vijay.kilari@gmail.com>
 <1390908022-10287-2-git-send-email-vijay.kilari@gmail.com>
 <20140129105546.GC26622@mudshark.cambridge.arm.com>
 <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
 <20140217130149.GA5856@arm.com>
 <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
 <20140218120249.GD11049@arm.com>
Message-ID: <CALicx6v6=WdRPoZ-vcxf7zusooB5r1V9WnjBf3QjOiO7yik3sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 5:32 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Feb 18, 2014 at 11:29:40AM +0000, Vijay Kilari wrote:
>> On Mon, Feb 17, 2014 at 6:31 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Mon, Feb 17, 2014 at 12:21:45PM +0000, Vijay Kilari wrote:
>> >>    If it is ok, can you please merge these patches
>> >
>> > I was about to merge them but I wanted to try first. Enabling kgd tests
>> > at boot time, I get plenty of failures as below. Have you successfully
>> > run the kgdb tests?
>>
>>   I re-tested v9 version patches with our internal arm64 simulator and
>> I don't see these warnings. Also I tested with 3.13 kernel from linaro with v8
>> foundation model and no errors are seen (logs below).
>
> It's good to know. Could you please rebase against 3.14-rc3 and rerun
> the tests? If they work, please send me your .config file that you used
> with the foundation model.
>
> (and since you rebase on 3.14-rc3, you could repost a v10 with all the
> acks in place so that it's easier for me to merge)
>

 Reposted v10 version of patches which is rebased on 3.14-rc3 kernel.
Test results are as follows on v8 foundation model.

 vda: vda1 vda2
kgdb: Registered I/O driver kgdbts.
kgdbts:RUN plant and detach test
kgdbts:RUN sw breakpoint test
kgdbts:RUN bad memory access test
kgdbts:RUN singlestep test 1000 iterations
kgdbts:RUN singlestep [0/1000]
kgdbts:RUN singlestep [100/1000]
kgdbts:RUN singlestep [200/1000]
kgdbts:RUN singlestep [300/1000]
kgdbts:RUN singlestep [400/1000]
kgdbts:RUN singlestep [500/1000]
kgdbts:RUN singlestep [600/1000]
kgdbts:RUN singlestep [700/1000]
kgdbts:RUN singlestep [800/1000]
kgdbts:RUN singlestep [900/1000]
kgdbts:RUN do_fork for 100 breakpoints
smc91x: not found (-19).
mousedev: PS/2 mouse device common for all mice
TCP: cubic registered
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
EXT4-fs (vda2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 254:2.
Freeing unused kernel memory: 256K (ffffffc0005d1000 - ffffffc000611000)
udevd[470]: starting version 182
EXT4-fs (vda2): re-mounted. Opts: data=ordered
random: dd urandom read with 11 bits of entropy available
rpcbind: cannot create socket for udp6
rpcbind: cannot create socket for tcp6
rpcbind: cannot get uid of '': Success
kgdb: Unregistered I/O driver kgdbts, debugger disabled.

Last login: Mon Jan 27 08:00:01 UTC 2014 on tty1
root at genericarmv8:~# uname -a
Linux genericarmv8 3.14.0-rc3+ #3 SMP PREEMPT Wed Feb 19 09:06:22 IST
2014 aarch64 GNU/Linux
root at genericarmv8:~#

.config is attached (renamed as config)

> Thanks.
>
> --
> Catalin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 37841 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/a0dfd53f/attachment-0001.obj>
