From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 13 Jul 2015 20:19:45 -0500
Subject: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
In-Reply-To: <20150713202611.GA16525@fifo99.com> (dwalker@fifo99.com's message
 of "Mon, 13 Jul 2015 20:26:11 +0000")
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
Message-ID: <87h9p7r0we.fsf@x220.int.ebiederm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwalker at fifo99.com writes:

> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>> 
>> > You can call panic notifiers and kmsg dumpers before kdump by
>> > specifying "crash_kexec_post_notifiers" as a boot parameter.
>> > However, it doesn't make sense if kdump is not available.  In that
>> > case, disable "crash_kexec_post_notifiers" boot parameter so that
>> > you can't change the value of the parameter.
>> 
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> I think it would make sense if he just replaced "kdump" with "kexec".

It would be less insane, however it still makes no sense as without
kexec on panic support crash_kexec is a noop.  So the value of the
seeting makes no difference.

Eric
