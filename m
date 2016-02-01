From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 1 Feb 2016 09:55:34 -0800
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <20160201173137.GV10826@n2100.arm.linux.org.uk>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
 <56A84748.3040108@oracle.com> <20160201152015.GU10826@n2100.arm.linux.org.uk>
 <56AF8F54.7030805@ti.com> <56AF917F.9030505@oracle.com>
 <20160201173137.GV10826@n2100.arm.linux.org.uk>
Message-ID: <56AF9C16.3090703@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/16 9:31 AM, Russell King - ARM Linux wrote:
> On Mon, Feb 01, 2016 at 09:10:23AM -0800, santosh shilimkar wrote:
>> Based on the log, I think the patch seems to work fine since the boot
>> reached upto rootfs. The crash seems to be coming from mostky NetCP
>> related compents.
>
> I read the boot log slightly differently - I'm assuming that the
> boot log is from the kernel which _will_ be kexec'd from, so we
> don't yet know whether the patches work or not.
>
I didn't see your [PATCH 2/2] which updates the kexec code with
idmap API. I see your point now but IIUC, this log isn't from
kexec kernel based on command line.

> I looked at the oops, and it's in tasklet_action, but for some
> reason the unwinder is unable to unwind and provide a backtrace,
> so it's not very debuggable.
>
> However, this is a useful backtrace for me in a different way:
> to provide to people who want to deprecate the frame-pointer
> based backtracing to prove why the unwinder based solution still
> isn't up to the job.
>
Indeed. Not having stack trace doesn't help.

Regards,
Santosh
