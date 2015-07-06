From: panand@redhat.com (Pratyush Anand)
Date: Mon, 6 Jul 2015 17:24:08 +0530
Subject: [PATCH 2/2] arm64: Make all entry code as non-kprobe-able
In-Reply-To: <559A6075.5070502@hitachi.com>
References: <cover.1436158027.git.panand@redhat.com>
 <683f80cef9b2b778be868e77b01a245585448a86.1436158027.git.panand@redhat.com>
 <559A6075.5070502@hitachi.com>
Message-ID: <20150706115408.GC17305@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2015:08:03:17 PM, Masami Hiramatsu wrote:
> On 2015/07/06 14:03, Pratyush Anand wrote:
> > Entry symbols are not kprobe safe. So blacklist them for kprobing.
> 
> As I've said, you can also use _ASM_NOKPROBE().

Thanks for this info.. May be we can use it if we find some single
discrete asm routines. Since here all the entry routines need to be
blacklisted, so may be this approach should be fine. This approach
have been emulated from x86 entry code blacklist.

> This patch itself looks good to me, but I'd like to ask arm64
> maintainers' opinion, whether they accept introducing entry-text
> section only for this purpose or not.
> 
> Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Thanks.

~Pratyush
