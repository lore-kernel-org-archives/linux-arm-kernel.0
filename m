From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Jul 2014 10:23:31 -0700
Subject: [PATCH v2 1/3] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <20140714091057.GP2081@ulmo>
References: <1405092672-18549-1-git-send-email-thierry.reding@gmail.com>
 <53C05E4A.2030708@codeaurora.org> <20140714091057.GP2081@ulmo>
Message-ID: <53C41213.6020102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/14 02:10, Thierry Reding wrote:
> The reason behind this was that people have been told to migrate towards
> using io{read,write}{8,16,32}_rep() because {read,write}s{b,w,l}() are
> not as "portable". The only reason why the aren't portable is because no
> generic versions of them existed. That's what this series originally
> started out as.
>
> Also, it's somewhat backwards (and inconsistent) to go through the io*()
> functions when it's known up front that the device will always only be
> memory-mapped and never I/O mapped. So with these patches going forward,
> people should be using either {read,write}{,s}{b,w,l}() *or* their
> io{read,write}{8,16,32}{,_rep}() counterparts, not mixing them.
>

Thanks. Can we please have this explanation in the commit text?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
