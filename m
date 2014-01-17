From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jan 2014 12:28:40 +0000
Subject: [PATCH] audit: Modify a set of system calls in audit class
 definitions
In-Reply-To: <1389945903-4326-1-git-send-email-takahiro.akashi@linaro.org>
References: <1389945903-4326-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140117122840.GG16003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 08:05:03AM +0000, AKASHI Takahiro wrote:
> Each asm-generic/audit_xx.h defines a set of system calls for respective
> audit permssion class (read, write, change attribute or exec).

permission

> This patch changes two entries:
> 
> 1) fchown in audit_change_attr.h
>   Make fchown included by its own because in asm-generic/unistd.h, for example,
>   fchown always exists while chown is optional. This change is necessary at
>   least for arm64.
> 
> 2) truncate64 in audit_write.h
>   Add missing truncate64/ftruncate64 as well as truncate/ftruncate
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
