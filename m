From: FuXinRong@skyworth.com (=?gb2312?B?uLbQwsjZ?=)
Date: Tue, 27 Oct 2009 12:05:42 +0800
Subject: =?gb2312?B?tPC4tDogQWJvdXQgdGhlIHN5c3RlbSBjYWxsIG5hbWVkICJzeXNfbW91bnQ=?=
	=?gb2312?B?Ii4=?=
Message-ID: <1C70663C229ECE40981BAC25C6482BC40739101E@SZHOMailBE01.skyworth.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the"c2" register of CP15 isn't changed within the execution of "SWI" instruction.
in a other words, the page table isn't changed.
the reference of the user space data is possible  at this time.
but i worry there are some issues when the data is swaped.



-----????-----
???: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
????: 2009?10?19? 18:22
???: ???
??: linux-arm-kernel at lists.infradead.org
??: Re: About the system call named "sys_mount".

On Mon, Oct 19, 2009 at 05:57:21PM +0800, ??? wrote:
> if there is no potential risk, the speed of "mount" command would be 
> improved greatly.  Tell me plz if there is problem. thax.

1. You're risking a kernel oops, caused by direct dereferencing of
   user pointers
2. The cost of copying parameters in sys_mount has nothing to do with
   the speed - the biggest issue will be accessing the media itself.
