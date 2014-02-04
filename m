From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 04 Feb 2014 17:36:47 +0000
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <20140117110830.GW3471@alberich>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com> <
 20140117110830.GW3471@alberich>
Message-ID: <20140204173647.4B0D6C40B12@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jan 2014 12:08:30 +0100, Andreas Herrmann <andreas.herrmann@calxeda.com> wrote:
> 
> arm-smmu driver uses of_parse_phandle_with_args when parsing DT
> information to determine stream IDs for a master device.
> Thus the number of stream IDs per master device is bound by
> MAX_PHANDLE_ARGS.
> 
> To support Calxeda ECX-2000 hardware arm-smmu driver requires a
> slightly higher value for MAX_PHANDLE_ARGS as this hardware has 10
> stream IDs for one master device.
> 
> Increasing it to 16 seems a reasonable choice.
> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>

I've merged this one, but I'm not excited about making it any larger
because this structure lives on the stack most of the time.

g.
