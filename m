From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Jul 2014 15:04:28 +0100
Subject: [PATCH 0/3] ARM: perf: allow tracing with kernel tracepoints
 events
In-Reply-To: <1404740710-14691-1-git-send-email-jean.pihet@linaro.org>
References: <1404740710-14691-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140709140427.GP9485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Mon, Jul 07, 2014 at 02:45:07PM +0100, Jean Pihet wrote:
> - Robustify the user backtrace code, as done on other architectures.
> - Provide the symbols resolution when triggering from tracepoints.
> 
> Big thanks to Steve Capper for the help in debugging and rephrasing the
> commits descriptions.
> 
> Stress tested with perf record and tracepoints triggering (-e <tracepoint>),
> with unwinding using fp (--call-graph fp) and dwarf info (--call-graph dwarf).

I've taken the first two in this series, but patch 3 still doesn't address
my concerns about saving the required register state for unwinding.

Thanks!

Will
