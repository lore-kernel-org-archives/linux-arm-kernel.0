From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 7 Mar 2018 11:04:08 +0100
Subject: [RFC V3 0/3] perf stat: improvements for handling of multiple PMUs
In-Reply-To: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20180307100408.GA22848@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 09:04:41AM -0500, Agustin Vega-Frias wrote:
> This series of patches adds some simple improvements to the way perf stat
> handles PMUs that have multiple instances by:
> 
> 1. Adding glob-like matching in addition to the prefix-based matching
>    introduced previously (patch 1).
> 2. Adding the ability to recover the PMU names when printing the events
>    separately with the --no-merge option (patch 2).
> 3. Restoring auto-merge for events created by prefix or glob-like match
>    (patch 3). Note that this still keeps the behavior that disables
>    auto-merging of legacy symbolic events (e.g. cycles).
> 
> V3:
> 
> - Consolidated prefix and glob matching into a single glob match with a
>   trailing * to maintain prefix matching and have more consistent behavior.
>   E.g., all of these match all the uncore_imc PMUs: imc, imc*, *imc, *imc*

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
