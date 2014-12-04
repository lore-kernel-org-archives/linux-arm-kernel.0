From: dave.long@linaro.org (David Long)
Date: Wed, 03 Dec 2014 21:48:19 -0500
Subject: [PATCH v3 0/5] ARM64: Add kernel probes(Kprobes) support
In-Reply-To: <547FB5DD.901@redhat.com>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <20141120135851.GA32528@linaro.org> <54759041.9080105@hitachi.com>
 <20141126100325.GA9157@linaro.org> <5476120D.9030703@linaro.org>
 <CAPvkgC3eVOZEn79C9PC9c7TqC_-yCtDhw5LL6ZWUJxr+oQFaow@mail.gmail.com>
 <5476BFB4.2020705@hitachi.com>
 <CAPvkgC0ELPPWfa-8kQ4H_e_O5G1ER4KEKuSWLxh_u-VZgh7W6A@mail.gmail.com>
 <547C36DB.7060903@hitachi.com> <547F242D.1060705@redhat.com>
 <547F94B0.1000902@linaro.org> <547FB5DD.901@redhat.com>
Message-ID: <547FCB73.1010707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 20:16, William Cohen wrote:

[...]

>
> The perf issue seems to be independent and can be reproduced without using any kprobe support.  I need to get a simple reproducer and mention it on the linux-perf-user list.
>
> -Will
>


OK, my confusion came from all the different things perf can use.  I 
have not yet been able to reproduce the "perf stat" failure, but I do 
see the failure with Steve's example using tracepoints.  I had thought 
that was using kprobes, but apparently it just uses tracepoints.  These 
look like two different failures to me:  One related to tracepoints, and 
one in the PMU driver.

Since this seems unrelated to kprobes I don't plan on pursuing these 
particular problems.

-dl
