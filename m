From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 30 Dec 2013 09:33:50 +0530
Subject: [PATCH RESEND 1/4] clk: clk-s2mps11: Refactor for including
 support for other MFD clocks
In-Reply-To: <20131229221723.12054.40917@quantum>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1388053141-30085-1-git-send-email-tushar.behera@linaro.org>
 <1388053141-30085-2-git-send-email-tushar.behera@linaro.org>
 <20131229221723.12054.40917@quantum>
Message-ID: <CAHbNUh0tJHXv52bA9hBDZMH0Pi+x9uC=LojcvgS=ONnCgEmVTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 December 2013 03:47, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Tushar Behera (2013-12-26 02:18:58)
>> The clocks in S2MPS11 and S5M8767 are managed in the same way, baring
>> a difference in the register offset. It would be better to update
>> existing S2MPS11 driver to support the clocks in S5M8767, rather than
>> creating an almost duplicate driver altogether.
>
> Can you rebase patches #1 & #2 onto clk-next? They do not apply cleanly
> as-is.
>
> Regards,
> Mike
>

Commit 1b1ccee1e821 "mfd: s2mps11: Fix build after regmap field rename
in sec-core.c" is also touching this file, which is in Mark's tree
right now. If I rebase
this patch on top clk-next, I am getting conflicts when I merge that
with linux-next.
Let me know how you want to handle this.

I am attaching the rebased patches for your reference.
If you want, I will send them again through git-send-email.

-- 
Tushar Behera
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-clk-clk-s2mps11-Refactor-for-including-support-for-o.patch
Type: text/x-patch
Size: 2904 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/fbd9b99e/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-clk-clk-s2mps11-Add-support-for-clocks-in-S5M8767-MF.patch
Type: text/x-patch
Size: 2224 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/fbd9b99e/attachment-0001.bin>
