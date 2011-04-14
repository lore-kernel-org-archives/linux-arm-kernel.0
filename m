From: sjg@chromium.org (Simon Glass)
Date: Thu, 14 Apr 2011 16:02:17 -0700
Subject: [PATCH v3] ARM: Use generic BUG() handler
In-Reply-To: <4D9DFB08.8090206@codeaurora.org>
References: <1302131890-20953-1-git-send-email-sjg@chromium.org>
	<4D9DFB08.8090206@codeaurora.org>
Message-ID: <BANLkTikRDowxG+q5tnhCCsCWCQEk-thqGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 7, 2011 at 10:57 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 04/06/2011 04:18 PM, Simon Glass wrote:
>> From: Simon Glass <sjg@google.com>
>>
>> ARM uses its own BUG() handler which makes its output slightly different
>> from other archtectures.
>>
> [snip]
>>
> Also, have you tried this with a module? I think you would at least need
> to modify arch/arm/kernel/module.c to hook up the module_bug_finalize()
> and module_bug_cleanup() stuff.

Actually this just works, except that I need to allow the PC to be
below PAGE_OFFSET where modules are loaded. This is a benefit of using
generic Linux code.

I have sent a new version of the patch to review.

Regards,
Simon
