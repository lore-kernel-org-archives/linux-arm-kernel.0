From: nschichan@freebox.fr (Nicolas Schichan)
Date: Thu, 30 Apr 2015 14:35:31 +0200
Subject: [PATCH 0/4] Seccomp filter JIT support on ARM.
In-Reply-To: <554108CC.6000801@iogearbox.net>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
 <554108CC.6000801@iogearbox.net>
Message-ID: <55422193.9010905@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2015 06:37 PM, Daniel Borkmann wrote:
> On 04/29/2015 03:37 PM, Nicolas Schichan wrote:
> ...
>> The fourth and final patch fixes a bug in the emit_udiv() function
>> when used to convert a BPF_ALU | BPF_DIV | BPF_K instruction in the
>> ARM BPF JIT code.
> 
> Shouldn't that fix go separately, so it can be included into 4.1
> resp. -stable?

Sure, shall I resend that separately from the v2 of the serie or is it fine in
its current form ?

> Would be good if you also Cc Mircea, who wrote the code. Was that
> caught by lib/test_bpf.c suite (if not, would be good to add a test
> case for it) ?

It was detected by an internal test suite we have here. I see that there are
some BPF_ALU | BPF_DIV | BPF_K instructions so it might also be caught by
lib/test_bpf.c as well.

Regards,

-- 
Nicolas Schichan
Freebox SAS
