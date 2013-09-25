From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 25 Sep 2013 11:16:05 -0400
Subject: [PATCH v1 2/7] arm64: introduce interfaces to hotpatch kernel
 and module code
In-Reply-To: <CA+b37P0P0RhUytnkLSXmz28wzzsoL3-viV2oxNJqq2nP7kZBFA@mail.gmail.com>
References: <1380105868-31985-1-git-send-email-liuj97@gmail.com>
 <1380105868-31985-3-git-send-email-liuj97@gmail.com>
 <20130925103535.2249f617@gandalf.local.home>
 <CA+b37P0P0RhUytnkLSXmz28wzzsoL3-viV2oxNJqq2nP7kZBFA@mail.gmail.com>
Message-ID: <20130925111605.7437f70f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Sep 2013 20:12:17 +0530
Sandeepa Prabhu <sandeepa.prabhu@linaro.org> wrote:


> > On aarch64, are instructions always word aligned? If not, it should be
> > safe for stop machine to modify non word aligned instructions, but this
> > patch looks like it doesn't allow stop_machine() to do so.
> Steve,
> 
> Yes, aarch64 instructions must be word-aligned, else instruction fetch
> would generate Misaligned PC fault.
> 

Thanks for clarifying, as IIUC, there's ARM architectures that allow
for 2 and 4 byte instructions.

-- Steve
