From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 10 Mar 2015 12:27:23 +0100
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150310112723.GY2896@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 12:46:30PM +0000, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> Don't allow grouping hardware events from different PMUs
>  (eg. CCI + CPU).

Uhm, how does this work? If we have multiple hardware PMUs we'll stop
scheduling events after the first failed event schedule. This can leave
one of the PMUs severely under utilized.
