From: hidehiro.kawai.ez@hitachi.com (Hidehiro Kawai)
Date: Tue, 14 Jul 2015 10:56:13 +0900
Subject: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
In-Reply-To: <20150713202611.GA16525@fifo99.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org> <20150713202611.GA16525@fifo99.com>
Message-ID: <55A46C3D.7000208@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric and Daniel,

(2015/07/14 5:26), dwalker at fifo99.com wrote:
> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>>
>>> You can call panic notifiers and kmsg dumpers before kdump by
>>> specifying "crash_kexec_post_notifiers" as a boot parameter.
>>> However, it doesn't make sense if kdump is not available.  In that
>>> case, disable "crash_kexec_post_notifiers" boot parameter so that
>>> you can't change the value of the parameter.
>>
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> You are confusing kexec on panic and CONFIG_CRASH_DUMP
>> which is about the tools for reading the state of the previous kernel.

You are right.  I mistook the meaning of CONFIG_CRASH_DUMP.

> I think it would make sense if he just replaced "kdump" with "kexec".

If a user specified crash_kexec_post_notifiers option with kexec
being totally disabled, it just disables notifier and kmsg dumper calls
(please see PATCH 3/3). So as Daniel said, I also think it makes sense
to hide crash_kexec_post_notifiers option if kexec is disabled.

Regards,

-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
