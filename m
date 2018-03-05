From: ak@linux.intel.com (Andi Kleen)
Date: Mon, 05 Mar 2018 09:55:19 -0800
Subject: [RFC V2 1/3] perf,
 tools: Support wildcards on pmu name in dynamic pmu events
In-Reply-To: <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org> (Agustin
 Vega-Frias's message of "Mon, 05 Mar 2018 10:08:18 -0500")
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
 <20180303143436.GA14563@krava>
 <20180304171245.GB25017@tassilo.jf.intel.com>
 <20180304181010.GA7030@krava>
 <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org>
Message-ID: <87efky76go.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Agustin Vega-Frias <agustinv@codeaurora.org> writes:
>
> An option to keep backward compatibility and consistency would be
> to wrap the pattern/string passed in *'s, that way we can just use
> fnmatch and have all the examples Jiri brought up work the same.
> With that in place we can actually also drop the explicit ignoring
> of the uncore_ prefix since the globbing would take care of that.

Prepending with * would seem dangerous, could result in false
matches. But adding it at the end should be ok.

-Andi
