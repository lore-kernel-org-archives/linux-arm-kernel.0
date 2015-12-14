From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Mon, 14 Dec 2015 09:27:18 -0600
Subject: [RFC PATCH 0/3] livepatch: arm64: add support for livepatch on
 arm64
In-Reply-To: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
References: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <20151214152718.GA11552@treble.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 08:49:35PM +0800, Li Bin wrote:
> This patchset depends on the on-going gcc feature "-fprolog-pad=N",
> which will generate a pad of N nops at the beginning of each function.
> 
> Livepatch on arm64 can using the feature (that always placing one nop
> at the beginning of the function). And when enable/disable func patching,
> just modify the pad code to nop or branch. And that NOP and B instruction
> are both safe instructions on arm64 which called "concurrent modification
> and execution of instructions", that can be executed by one thread of
> execution as they are being modified by another thread of execution without
> requiring explicit synchronization.
> 
> And this method will improve performance significantly compared with the
> method based on ftrace, especially for the critical function being frequently
> called.

I think the arch-specific code in this patch set would be greatly
affected by the consistency model when it finally arrives (but that's
currently gated by getting stacktool merged, which should be soon).

So I think it would be a good idea to wait until then before doing
something like this.

Is it possible to use ftrace instead?  That would be a much better short
term solution.

-- 
Josh
