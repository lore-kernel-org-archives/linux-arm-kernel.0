From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 23 Jan 2018 13:44:19 -0600
Subject: [RFC PATCH 1/2] arm64: fpsimd: Fix bad si_code for undiagnosed
 SIGFPE
In-Reply-To: <20180123.132916.1025436873838680654.davem@davemloft.net> (David
 Miller's message of "Tue, 23 Jan 2018 13:29:16 -0500 (EST)")
References: <878tcp8umz.fsf@xmission.com>
 <20180123101446.GP22781@e103592.cambridge.arm.com>
 <87tvvc77nf.fsf@xmission.com>
 <20180123.132916.1025436873838680654.davem@davemloft.net>
Message-ID: <87lggo7430.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Miller <davem@davemloft.net> writes:

> From: ebiederm at xmission.com (Eric W. Biederman)
> Date: Tue, 23 Jan 2018 12:27:16 -0600
>
>> Dave Martin <Dave.Martin@arm.com> writes:
>> 
>>> On Mon, Jan 22, 2018 at 03:13:08PM -0600, Eric W. Biederman wrote:
>>> However, the purpose of this as an RFC was to get feedback on whether
>>> adding FPE_UNKNOWN is considered acceptable at all from an API
>>> perspective -- the precise number doesn't matter for that discussion.
>>>
>>> Do you have any view on this?
>> 
>> That seems as good a solution as any too me.  It is reality and it
>> happens in the code and there are several places of the same form I
>> would use it, just to get rid of the FPE_FIXME.
>
> Eric, feel free to do something similar on Sparc.

Will do.

This sounds like a good solution for this weird corner case, that
appears on multiple architectures.

Eric
