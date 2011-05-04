From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 May 2011 15:21:26 +0100
Subject: [ARM]crash on 2.6.35.11
In-Reply-To: <BANLkTik17MGwWwFb=CzBduFy9Mn-Ze+ptA@mail.gmail.com>
References: <BANLkTimLd-qY-OeKqnf2EoTfvAHWQZVchw@mail.gmail.com>
	<BANLkTi=xz4w3p4bc5T4-YvkC3tYdwKhWGA@mail.gmail.com>
	<BANLkTik17MGwWwFb=CzBduFy9Mn-Ze+ptA@mail.gmail.com>
Message-ID: <BANLkTi=WYk3_wQ8R1x9JD3-A+asO3cyo4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(fixing up the linux-arm-kernel list address)

On 4 May 2011 14:18, naveen yadav <yad.naveen@gmail.com> wrote:
> On Wed, May 4, 2011 at 3:55 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On 4 May 2011 11:09, naveen yadav <yad.naveen@gmail.com> wrote:
>>> We are running linux kernel 2.6.35.11 on Cortex a-8. when I run a
>>> simple program expect to give oom.
>>> ?But it crash with following crash log
>>
>> Could you post the full kernel boot log and .config file?
>
> Pls find attached log

It looks like a problem with the memory configuration on your board.
You have sparsemem sections which are not fully populated. The
mainline kernel still has problems in this area.

You can try this patch (not sure it applies cleanly on 2.6.35 but it's
not difficult to fix):

http://article.gmane.org/gmane.linux.ports.arm.kernel/112994

-- 
Catalin
