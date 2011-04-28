From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Apr 2011 17:44:21 +0100
Subject: [PATCH] arm:pm: save the vfp state of last scheduled-out proceed
	while suspending
In-Reply-To: <1303885825-5411-1-git-send-email-bs14@csr.com>
References: <1303885825-5411-1-git-send-email-bs14@csr.com>
Message-ID: <BANLkTik2shB+RPqheM8fFn8DitmsReAJHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 April 2011 07:30, Barry Song <bs14@csr.com> wrote:
> From: Rongjun Ying <rongjun.ying@csr.com>
>
> Current vfp pm suspend entry only saves the vfp state of running proceed if it is using vfp. If current proceed doesn't use vfp,
> the state of last process will be lost after resume. In pressure tests, we can see old vfp processes crash after resume.
>
> In order that schedule can be faster, scheduler doesn't save vfp state if we schedule from proceeds using vfp to proceeds which
> don't use vfp. If system suspend happens just at proceeds which don't use vfp, we have no any chance to save old vfp state.
>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Cc: Binghua Duan <binghua.duan@csr.com>
> Signed-off-by: Barry Song <21cnbao@gmail.com>

There was a similar patch some time ago by Colin Cross. I don't know
what happened to it but please have a look at that discussion first:

http://thread.gmane.org/gmane.linux.kernel/1099558

-- 
Catalin
