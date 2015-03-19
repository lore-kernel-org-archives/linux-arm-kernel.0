From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 17:14:43 +0000
Subject: [PATCHv2 0/3] [4.0] arm/arm64: Do not group hardware events from
 different PMUs
In-Reply-To: <1426616100-31628-1-git-send-email-suzuki.poulose@arm.com>
References: <1426616100-31628-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150319171443.GA10153@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 06:14:57PM +0000, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> This is a collection of fixes which denies grouping hardware events
> from different PMUs. They also fix crashes triggered by perf_fuzzer
> on Linux-4.0-rc2.
> 
> This series hasn't changed since V1, except for better commit messages.
> 
> Similar fixes are required in ARM-CCN PMU driver and is not straight forward
> as these changes.
> 
> Suzuki K. Poulose (3):
>   arm/pmu: Reject groups spanning multiple hardware PMUs
>   arm64/pmu: Reject groups spanning multiple HW PMUs
>   arm-cci: Reject groups spanning multiple HW PMUs

For the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  arch/arm/kernel/perf_event.c   |   21 +++++++++++++++------
>  arch/arm64/kernel/perf_event.c |   21 +++++++++++++++------
>  drivers/bus/arm-cci.c          |   19 ++++++++++++++-----
>  3 files changed, 44 insertions(+), 17 deletions(-)
> 
> -- 
> 1.7.9.5
> 
