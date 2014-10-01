From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 1 Oct 2014 10:40:02 -0400
Subject: [PATCHv2 5/5] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <1412165279-8709-6-git-send-email-punit.agrawal@arm.com>
References: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
 <1412165279-8709-6-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141001104002.4efbde6f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  1 Oct 2014 13:07:59 +0100
Punit Agrawal <punit.agrawal@arm.com> wrote:

> Introduce an event to trace the usage of emulated instructions. The
> trace event is intended to help identify and encourage the migration
> of legacy software using the emulation features.
> 
> Use this event to trace usage of swp and CP15 barrier emulation.

Do you expect this to be a generic tracepoint? Something any arch can
use, and more importantly, will use?

If not, please keep this tracepoint in the arch/arm64 directories. The
sample code in samples/trace_events/ explains how to do this.

Thanks,

-- Steve
