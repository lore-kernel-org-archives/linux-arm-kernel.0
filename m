From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 18 Apr 2011 11:42:26 +0100
Subject: [PATCH] Fix infinite loop in ARM user perf_event backtrace code
In-Reply-To: <1302924445-18557-1-git-send-email-sonnyrao@chromium.org>
References: <1302924445-18557-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <20110418104226.GA2820@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 15, 2011 at 08:27:25PM -0700, Sonny Rao wrote:
> The ARM user backtrace code can get into an infinite loop if it
> runs into an invalid stack frame which points back to itself.
> This situation has been observed in practice.  Fix it by capping
> the number of entries in the backtrace.  This is also what other
> architectures do in their backtrace code.

Tested on my v6k board and looks good.

> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
