From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 06 Jul 2015 20:37:49 +0900
Subject: [PATCH 1/2] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <20150706090323.GB30342@arm.com>
References: <cover.1436158027.git.panand@redhat.com>
 <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
 <20150706090323.GB30342@arm.com>
Message-ID: <559A688D.1040501@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/07/06 18:03, Will Deacon wrote:
> On Mon, Jul 06, 2015 at 06:03:21AM +0100, Pratyush Anand wrote:
>> Add all function symbols which are called from do_debug_exception under
>> NOKPROBE_SYMBOL, as they can not kprobed.
> 
> It's a shame this has to be so manual, but I suppose it's done on a
> best-effort basis to catch broken probe placement.

Ah, yes. You can use kprobe-tracer in ftrace by feeding all symbols to
them and enabling it (and pray).


> If we miss a function and somebody probes it, do we just get stuck in a
> recursive exception, or could we print something suggesting that a symbol
> be annotated as NOKPROBE?

For some cases we can detect recursion, but usually, it may reset
itself or infinite recursion loop before detecting it. :(

Thank you,

-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt at hitachi.com
