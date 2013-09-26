From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Thu, 26 Sep 2013 08:17:45 +0530
Subject: [PATCH v1 2/7] arm64: introduce interfaces to hotpatch kernel and
 module code
In-Reply-To: <20130925111605.7437f70f@gandalf.local.home>
References: <1380105868-31985-1-git-send-email-liuj97@gmail.com>
 <1380105868-31985-3-git-send-email-liuj97@gmail.com>
 <20130925103535.2249f617@gandalf.local.home>
 <CA+b37P0P0RhUytnkLSXmz28wzzsoL3-viV2oxNJqq2nP7kZBFA@mail.gmail.com>
 <20130925111605.7437f70f@gandalf.local.home>
Message-ID: <CA+b37P2yQOo8X1jyPC-QxRbJ1EHL7U06hC_26Gn0SnhMhJKCuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2013 20:46, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 25 Sep 2013 20:12:17 +0530
> Sandeepa Prabhu <sandeepa.prabhu@linaro.org> wrote:
>
>
>> > On aarch64, are instructions always word aligned? If not, it should be
>> > safe for stop machine to modify non word aligned instructions, but this
>> > patch looks like it doesn't allow stop_machine() to do so.
>> Steve,
>>
>> Yes, aarch64 instructions must be word-aligned, else instruction fetch
>> would generate Misaligned PC fault.
>>
>
> Thanks for clarifying, as IIUC, there's ARM architectures that allow
> for 2 and 4 byte instructions.
Yes, ARM 32-bit mode would support both 32-bit and 16-bit alignment
based on ARM or Thumb mode, whereas
AArch64 (in arch/arm64/) is always 32-bit instructions and PC need to
be aligned to 32-bit address.

Thanks,
Sandeepa
>
> -- Steve
