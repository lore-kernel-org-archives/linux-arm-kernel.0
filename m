From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 17 Dec 2015 15:52:13 -0600
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <20151211120419.GD18828@arm.com>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
 <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
 <20151211084133.GE6356@twins.programming.kicks-ass.net>
 <20151211120419.GD18828@arm.com>
Message-ID: <56732E8D.8050706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2015 06:04 AM, Will Deacon wrote:
> I think Andrew meant the atomic_xchg_acquire at the start of osq_lock,
> as opposed to "compare and swap". In which case, it does look like
> there's a bug here because there is nothing to order the initialisation
> of the node fields with publishing of the node, whether that's
> indirectly as a result of setting the tail to the current CPU or
> directly as a result of the WRITE_ONCE.
>
> Andrew, David: does making that atomic_xchg_acquire and atomic_xchg
> fix things for you?
>
> I don't fully grok what 81a43adae3b9 has to do with any of this, so
> maybe there's another bug too.

Will,

I ran into this problem while getting a machine to boot with ACPI
yesterday. Your suggested fix works on that machine.

Thanks, so for that patch.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>






IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
