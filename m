From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 9 Nov 2015 22:53:17 -0600
Subject: [PATCH V2 2/3] scsi: fix compiler warning for sg
In-Reply-To: <564177D7.7070103@codeaurora.org>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <1447034266-28003-3-git-send-email-okaya@codeaurora.org>
 <CAHp75VdUBKr_XQ=2_5uSww71YVz+-Shmhg5hSe5KAoeshTtMYQ@mail.gmail.com>
 <564162AB.6080803@codeaurora.org> <564163F7.2020109@codeaurora.org>
 <564177D7.7070103@codeaurora.org>
Message-ID: <5641783D.3030108@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
>
> The code says it is using these macros for small integers only which
> can't overflow. I was trying to get rid of compiler warning and it seems
> to have disappeared.

I would double-check the assembly code, if I were you.  I don't like it 
when warnings just go away like that.

Besides, we *should* be using do_div() for 64-bit division.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
