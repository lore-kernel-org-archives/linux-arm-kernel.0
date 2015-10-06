From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Oct 2015 11:19:57 +0100
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
Message-ID: <20151006101956.GB10492@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 11:05:43AM +0530, Manjeet Pawar wrote:
> MINSIGSTKSZ and SIGSTKSZ for ARM64 are not correctly set in latest kernel.
> This patch fixes this issue.
> 
> This issue is reported in LTP (testcase: sigaltstack02.c).
> Testcase failed when sigaltstack() called with stack size "MINSIGSTKSZ - 1"
> Since in Glibc-2.22, MINSIGSTKSZ is set to 5120 but in kernel
> it is set to 2048 so testcase gets failed.
> 
> Testcase Output:
> sigaltstack02 1  TPASS  :  stgaltstack() fails, Invalid Flag value,errno:22
> sigaltstack02 2  TFAIL  :  sigaltstack() returned 0, expected -1,errno:12

This test passes for me. What are you doing to trigger the failure?

Will
