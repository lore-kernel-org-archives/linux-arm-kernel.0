From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Aug 2015 17:22:18 +0100
Subject: [PATCH v8 7/7] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <1439254364-15362-8-git-send-email-dave.long@linaro.org>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <1439254364-15362-8-git-send-email-dave.long@linaro.org>
Message-ID: <CAPvkgC0DF5qkMgbVkgBZj8B3oyX47E5JUkr6nL+es-x5HJbK5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 August 2015 at 01:52, David Long <dave.long@linaro.org> wrote:
> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>
> Add info prints in sample kprobe handlers for ARM64
>
> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> ---
>  samples/kprobes/kprobe_example.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

I'm not going through this series backwards, but I did run the kprobe
sample modules first, and nothing happened... (i.e. nothing fired).

The kernel usage of do_fork (which is used as an example by the sample
code) has been changed by:
3033f14a clone: support passing tls argument via C rather than pt_regs magic

Now everything appears to go through _do_fork rather than do_fork.

I'll send a fixup shortly, but if anyone else is running these modules
and worrying about a lack of events... worry less :-).

Cheers,
--
Steve
