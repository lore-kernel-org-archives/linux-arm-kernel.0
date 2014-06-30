From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 30 Jun 2014 12:53:45 +0200
Subject: [PATCH 1/9 v2] coresight: add CoreSight core layer framework
In-Reply-To: <1403892261-25026-2-git-send-email-mathieu.poirier@linaro.org>
References: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>
 <1403892261-25026-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <53B141B9.2060401@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.06.2014 20:04, mathieu.poirier at linaro.org wrote:
> From: Pratik Patel <pratikp@codeaurora.org>
>
> CoreSight components are compliant with the ARM CoreSight
> architecture specification and can be connected in various
> topologies to suite a particular SoCs tracing needs. These trace
> components can generally be classified as sources, links and
> sinks. Trace data produced by one or more sources flows through
> the intermediate links connecting the source to the currently
> selected sink.
>
> CoreSight framework provides an interface for the CoreSight trace
> drivers to register themselves with. It's intended to build up a
> topological view of the CoreSight components and configure the
> right series of components on user input via debugfs.
>
> For eg., when enabling a source, framework builds up a path
> consisting of all the components connecting the source to the
> currently selected sink and enables all of them.
>
> Framework also supports switching between available sinks and
> also provides status information to user space applications
> through the debugfs interface.
>
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Panchaxari Prasannamurthy <panchaxari.prasannamurthy@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../devicetree/bindings/arm/coresight.txt          | 141 +++++
>   drivers/Kconfig                                    |   2 +

I wonder if

arch/arm/Kconfig.debug

wouldn't be better place for this?

Best regards

Dirk
