From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 3 Aug 2015 12:57:11 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <D7BD8A9F-8710-42D5-A0ED-8747D2B6B268@gmail.com>
References: <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
 <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
 <20150717104144.6588b2f7@gandalf.local.home>
 <0886A996-40E1-49E9-823C-85E55A858716@gmail.com>
 <1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>
 <20150720162004.GL9908@arm.com> <20150803090951.GA10501@arm.com>
 <D7BD8A9F-8710-42D5-A0ED-8747D2B6B268@gmail.com>
Message-ID: <20150803125711.65463359@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Aug 2015 01:30:50 +0900
Jungseok Lee <jungseoklee85@gmail.com> wrote:


> There are two issues in the current version.
> 1) The change does not work correctly when function_graph feature is enabled.
> 2) Akashi have raised an issue that size field of stack tracer is inaccurate.
> 
> So, I think this patch set is not ready yet.

Do you still want me to add code that does:

 if (*p == (stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET)) {

?

If you expect to need that, I can get it into the next merge window and
you can base the code of that in the merge window after that.

-- Steve
