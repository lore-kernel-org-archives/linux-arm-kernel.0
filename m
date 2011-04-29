From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 29 Apr 2011 11:08:19 +0800
Subject: [PATCH] arm:pm: save the vfp state of last scheduled-out proceed
	while suspending
In-Reply-To: <BANLkTik2shB+RPqheM8fFn8DitmsReAJHg@mail.gmail.com>
References: <1303885825-5411-1-git-send-email-bs14@csr.com>
	<BANLkTik2shB+RPqheM8fFn8DitmsReAJHg@mail.gmail.com>
Message-ID: <BANLkTinKTm1Qnwwpn1TyHbcXwguXoeC+6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,
Thanks.
2011/4/29 Catalin Marinas <catalin.marinas@arm.com>:
> On 27 April 2011 07:30, Barry Song <bs14@csr.com> wrote:
>> From: Rongjun Ying <rongjun.ying@csr.com>
>>
>> Current vfp pm suspend entry only saves the vfp state of running proceed if it is using vfp. If current proceed doesn't use vfp,
>> the state of last process will be lost after resume. In pressure tests, we can see old vfp processes crash after resume.
>>
>> In order that schedule can be faster, scheduler doesn't save vfp state if we schedule from proceeds using vfp to proceeds which
>> don't use vfp. If system suspend happens just at proceeds which don't use vfp, we have no any chance to save old vfp state.
>>
>> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
>> Cc: Binghua Duan <binghua.duan@csr.com>
>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>
> There was a similar patch some time ago by Colin Cross. I don't know
> what happened to it but please have a look at that discussion first:
>
> http://thread.gmane.org/gmane.linux.kernel/1099558

sorry, i didn't see any patch committed and lost the thread in lkml.

Seems like Rongjun's codes have handled Russel's last change but in
the "else". Russel handles it before the "if (fpexc & FPEXC_EN) {".
We will take over the test in
http://thread.gmane.org/gmane.linux.kernel/1099558 and continue to
send patch v3.

>
> --
> Catalin
>
