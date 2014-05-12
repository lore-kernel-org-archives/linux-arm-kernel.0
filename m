From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 May 2014 09:54:00 +0100
Subject: [PATCH v9 2/3] Documentation: devicetree: Add new binding for
 PSCIv0.2
In-Reply-To: <1399472847-14377-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
 <1399472847-14377-3-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <20140512085400.GA3006@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashwin,

On Wed, May 07, 2014 at 03:27:26PM +0100, Ashwin Chaugule wrote:
> The PSCI v0.2+ spec defines standard values for PSCI function IDs.
> Add a new binding entry so that pre v0.2 implementations can
> use DT entries for function IDs and v0.2+ implementations use
> standard entries as defined by the PSCIv0.2 specification.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

This looks good to me as a binding, and my prior comments all seem to
have been addressed. So:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

I have one minor comment regarding the final example. It would be nice
to be a little more explicit about the compatibility story there for
those people who are likely to skim the body of the document and only
read the examples.

[...]

> +Case 3: PSCI v0.2 and PSCI v0.1.
> +
> +	As described above, for compatibility with existing kernels, the
> +	hypervisor will likely want to provide IDs, e.g.

All we'd need here is to point out that the IDs will be ignored by a
PSCI 0.2 capable OS, which will assume the standard PSCI 0.2 IDs.

Could we replace the above with something like:

A DTB may provide IDs for use by kernels without PSCI 0.2 support,
enabling firmware and hypervisors to support existing and new kernels.
These IDs will be ignored by kernels with PSCI 0.2 support, which will
use the standard PSCI 0.2 IDs exclusively.

> +
> +	psci {
> +		compatible = "arm,psci-0.2", "arm,psci";
> +		method = "hvc";
> +
> +		cpu_on = < arbitrary value >;
> +		cpu_off = < arbitrary value >;
> +
> +		...
> +	};

Cheers,
Mark.
