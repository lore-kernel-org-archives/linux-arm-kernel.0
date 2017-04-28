From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Apr 2017 18:20:43 +0100
Subject: [PATCH v2 4/4] perf vendor events arm64: Add implementation
 defined pmu core events of ThunderX2
In-Reply-To: <1493355227-31492-5-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1493355227-31492-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1493355227-31492-5-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170428172043.GD13675@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 10:23:47AM +0530, Ganapatrao Kulkarni wrote:
> This is not a full event list, but a short list of useful events.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       | 14 +++++
>  .../arm64/thunderx2/implementation-defined.json    | 62 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile.csv
>  create mode 100644 tools/perf/pmu-events/arch/arm64/thunderx2/implementation-defined.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> new file mode 100644
> index 0000000..bc9f798
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -0,0 +1,14 @@
> +# Format:
> +#	MIDR,Version,JSON/file/pathname,Type
> +#
> +# where
> +#	MIDR	Processor version
> +#	Version could be used to track version of of JSON file
> +#		but currently unused.
> +#	JSON/file/pathname is the path to JSON file, relative
> +#		to tools/perf/pmu-events/arch/arm64/.
> +#	Type is core, uncore etc
> +#
> +#
> +#Family-model,Version,Filename,EventType
> +0x00000000420f5161,v1,thunderx2,core

In general, I don't think we want to require an exact match on the whole
MIDR here. Specifically, we'd want to mask out the Variant and Revision
fields for ARM CPUs, to avoid having to update the mapfile all the time.

Is it possible to support wildcarding in the MIDR match?

Will
