From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 13 Apr 2016 08:36:21 +0100
Subject: [RFC PATCH 1/2] ARM/ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1460526107.32510.138.camel@buserror.net>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-2-git-send-email-oss@buserror.net>
 <570B73CF.6070502@arm.com> <1460440128.32510.106.camel@buserror.net>
 <570CBAC5.8070406@arm.com> <1460526107.32510.138.camel@buserror.net>
Message-ID: <570DF6F5.3000107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/16 06:41, Scott Wood wrote:

[...]

> If the underlying representation is CompareValue, as the above suggests, then
> it makes sense that only tval would be affected, since the underlying problem
> is the counter.  The counter needs to be read in order to read or write tval. 
>  cval accesses the underlying representation directly, and the bad SoC clock
> logic doesn't have a chance to interfere.
> 
>> So I'd be really surprised if TVAL was buggy and CVAL was not (why would
>> loop around programming TVAL if you could hit CVAL and be correct?).
> 
> Switching to cval would be great, if everyone's OK with it.  We'd still need
> the loop on the counter.

Please only do that on the workaround path. I don't want sane platforms
to have to read the counter just to be able to program CVAL, as the core
code is only going to provide you with the delta that should be
programmed in TVAL.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
