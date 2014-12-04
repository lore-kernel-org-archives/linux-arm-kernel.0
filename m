From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 04 Dec 2014 20:53:03 +0900
Subject: [PATCH v3 0/5] ARM64: Add kernel probes(Kprobes) support
In-Reply-To: <CAPvkgC26-CprjLVH55=7z73JtxTumFFZ4W7itevXxMwReVqQ1g@mail.gmail.com>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <20141120135851.GA32528@linaro.org> <54759041.9080105@hitachi.com>
 <20141126100325.GA9157@linaro.org> <5476120D.9030703@linaro.org>
 <CAPvkgC3eVOZEn79C9PC9c7TqC_-yCtDhw5LL6ZWUJxr+oQFaow@mail.gmail.com>
 <5476BFB4.2020705@hitachi.com>
 <CAPvkgC0ELPPWfa-8kQ4H_e_O5G1ER4KEKuSWLxh_u-VZgh7W6A@mail.gmail.com>
 <547C36DB.7060903@hitachi.com> <547F242D.1060705@redhat.com>
 <547F94B0.1000902@linaro.org> <547FB5DD.901@redhat.com>
 <547FCB73.1010707@linaro.org>
 <CAPvkgC3=KKKMa1hWdOYOcV7D7kQSLtnNnXLBB64_P-V+_qUwTw@mail.gmail.com>
 <54803ADD.2090201@hitachi.com>
 <CAPvkgC26-CprjLVH55=7z73JtxTumFFZ4W7itevXxMwReVqQ1g@mail.gmail.com>
Message-ID: <54804B1F.3020703@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/12/04 20:29), Steve Capper wrote:

>> I'd like to ask you to try my fix on your machine, with my reproducing
>> methods. (do not use sytemtap nor perf, those can have other issues)
>>
> 
> Thank you Masami,
> 
> I tried the following commands:
> 
> echo "p:trace_event_buffer_lock_reserve
> trace_event_buffer_lock_reserve" >
> /sys/kernel/debug/tracing/kprobe_events
> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_exec/enable
> 
> The system appeared okay, I then cat'ed out:
> # cat /sys/kernel/debug/tracing/kprobe_profile
>    trace_event_buffer_lock_reserve                           25              25
> 
> I got similar output (i.e. no crashes) both with and without the
> interrupt fix you recommended.
> 
> I'm not sure how to interpret this, please let me know if you would
> like me to run any other tests?
> 
> (I did also try your proposed fix with perf + memcpy and that crashed
> in a similar way as before).

Hmm, then the bug is still there, and the bug may not be in the recursive
call path... We need to find another suspicious code in the patch.


Thank you,


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
