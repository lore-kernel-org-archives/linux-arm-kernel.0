Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43784C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F15205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFpLHy+Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKPdvkfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F15205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pBKpS/1mJKBfMiOZmosQHTyxvExyTbNDc2JpOYaDLtY=; b=CFpLHy+Z7Oc8cx
	nn0Lm5x+ZSfwOR83DYNVbQMyEWz+66NIci/5qM/nUMRk+QfzYZzvJ9+IsXQynN2nQTZAgiadiqknj
	MQujGT7QfDIBSHCr1FU6jtZtNNrgs416JfORFJnvIL17vkhamYdkTKnpirZB6m7HvFcJXGjieWP9z
	8Vim4YOhdTOKnV++XNfm+mMGlXLXf48UjkTepGXpgd6RDy5XEL9C59TD+ET/q+k4J8wv8eE1OkiNB
	6rFf7yL5ZYBj92zE1v7eIpb5PNnIW6JlP5EUcNQX+3qvj1efECDjVkLN2bJoxXDEQwtPDwnKmlbl9
	OaAUPN+2wZZjhkhmxlNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnmg-0006H2-7i; Wed, 16 Jan 2019 16:11:18 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnmX-0006Cz-J9
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:11:15 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so7557328wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qb6mpDlSdRPJh5ffkh1JVK8J7k1OQGONN7KrCy9QAVY=;
 b=FKPdvkfC4BQeI+yQWBidGD8GEl5InJTXnmlC8/nX3sK6T/I/dfrsZmrDRqzUMHmROQ
 Si3AbR3NHad0g4uoOtCFfT+7SJN7BXEyIPsG+3J4N9OqbgGEKP39YdciMbS0XJuj6nUy
 /bsgOiFQkMmTxUQIWSJeBbWeWnS99i+9bR/aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qb6mpDlSdRPJh5ffkh1JVK8J7k1OQGONN7KrCy9QAVY=;
 b=H3fIibI503hPo0dEPNNtIljq9Jp7x/3PgYcFbq8yQ2y6dbv8xTBLNQqyZYoq6x7laf
 PeqXTGLfwMmx/gMMw3tNxA5WhDHY2bYASrlaGyMdbKG3aLL0D/bLlQqNsqaBjK/pPyjT
 bmBApSDzBpkGTSFuOZAmWn9jJx/A/MAL6NBbUSLPiwHHKK5izIasHtyq2GH56gmfhChE
 nkfdc4N+iQLWq6i4o2/LrPXwEEVVYHUUzZfRbqIbaqa0YXCq0Y2zDmYvOACPADbCR0++
 u/zLZm1+gfam9msWTBy8aipaD7vJvqtt+rKs6dGlcYRAT3X3xvrBKFjuN1ytCGIpRXfg
 BiyA==
X-Gm-Message-State: AJcUukeAEchTXB+vhtrfKE02Gi69g4WQzmCFDIR1gHuh2EY6lLEt5q+7
 cXnOo+5D6yk7ijCkS0wAcFTC2w==
X-Google-Smtp-Source: ALg8bN7lf5wfl4/VDObrX6B9XHQ5yDbW3cg1vRo9U44/c3Ry/5vtZl677M/F8gYq5RPQ5CE2LZzDNA==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr7833762wrn.104.1547655066721; 
 Wed, 16 Jan 2019 08:11:06 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 08:11:05 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v13 0/8] Introduce on-chip interconnect API
Date: Wed, 16 Jan 2019 18:10:55 +0200
Message-Id: <20190116161103.6937-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_081109_649044_CA673E8A 
X-CRM114-Status: GOOD (  21.70  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: sanjayc@nvidia.com, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 daidavid1@codeaurora.org, bjorn.andersson@linaro.org, skannan@codeaurora.org,
 abailon@baylibre.com, vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
 khilman@baylibre.com, evgreen@chromium.org, ksitaraman@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, henryc.chen@mediatek.com, andy.gross@linaro.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, olof@lixom.net,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Modern SoCs have multiple processors and various dedicated cores (video, gpu,
graphics, modem). These cores are talking to each other and can generate a
lot of data flowing through the on-chip interconnects. These interconnect
buses could form different topologies such as crossbar, point to point buses,
hierarchical buses or use the network-on-chip concept.

These buses have been sized usually to handle use cases with high data
throughput but it is not necessary all the time and consume a lot of power.
Furthermore, the priority between masters can vary depending on the running
use case like video playback or CPU intensive tasks.

Having an API to control the requirement of the system in terms of bandwidth
and QoS, so we can adapt the interconnect configuration to match those by
scaling the frequencies, setting link priority and tuning QoS parameters.
This configuration can be a static, one-time operation done at boot for some
platforms or a dynamic set of operations that happen at run-time.

This patchset introduce a new API to get the requirement and configure the
interconnect buses across the entire chipset to fit with the current demand.
The API is NOT for changing the performance of the endpoint devices, but only
the interconnect path in between them.

The API is using a consumer/provider-based model, where the providers are
the interconnect buses and the consumers could be various drivers.
The consumers request interconnect resources (path) to an endpoint and set
the desired constraints on this data flow path. The provider(s) receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Below is a simplified diagram of a real-world SoC topology. The interconnect
providers are the NoCs.

+----------------+    +----------------+
| HW Accelerator |--->|      M NoC     |<---------------+
+----------------+    +----------------+                |
                        |      |                    +------------+
 +-----+  +-------------+      V       +------+     |            |
 | DDR |  |                +--------+  | PCIe |     |            |
 +-----+  |                | Slaves |  +------+     |            |
   ^ ^    |                +--------+     |         |   C NoC    |
   | |    V                               V         |            |
+------------------+   +------------------------+   |            |   +-----+
|                  |-->|                        |-->|            |-->| CPU |
|                  |-->|                        |<--|            |   +-----+
|     Mem NoC      |   |         S NoC          |   +------------+
|                  |<--|                        |---------+    |
|                  |<--|                        |<------+ |    |   +--------+
+------------------+   +------------------------+       | |    +-->| Slaves |
  ^  ^    ^    ^          ^                             | |        +--------+
  |  |    |    |          |                             | V
+------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
| CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
          |
      +-------+
      | Modem |
      +-------+

It's important to note that the interconnect API, in contrast with devfreq,
is allowing drivers to express their needs in advance and be proactive.
Devfreq is using a reactive approach (e.g. monitor performance counters and
reconfigure bandwidth when the bottleneck had already occurred), which is
suboptimal and might not work well. The interconnect API is designed to
deal with multi-tiered bus topologies and aggregating constraints provided
by drivers, while the devfreq is more oriented towards a device like GPU
or CPU, that controls the power/performance of itself and not other devices.

Some examples of how interconnect API is used by consumers:
https://lkml.org/lkml/2018/12/20/811
https://lkml.org/lkml/2019/1/9/740
https://lkml.org/lkml/2018/10/11/499
https://lkml.org/lkml/2018/9/20/986

Platform drivers for different SoCs are available:
https://lkml.org/lkml/2018/11/17/368
https://lkml.org/lkml/2018/8/10/380

TODO:
* Create icc_set() to handle multiple parameters such as latency and other
  QoS values. Nvidia and Qcom guys are interested in this.
* Cache the path between nodes instead of walking the graph on each get().
* Sync interconnect requests with the idle state of the device.

Changes since patchset v12 (https://lkml.org/lkml/2018/12/8/152)
* Rebased on v5.0-rc2
* Picked Acked-by/Reviewed-by Rob Herring.
* Renamed icc_set() to icc_set_bw() in patch 1. Rob suggested that icc_set()
  is a too generic name of a function that sets only bandwidth. In the future
  we plan to support also latency and priority.
* Extended the cover letter with info why devfreq is not a good fit and added
  links to consumer drivers as suggested by Olof Johansson and Mike Turquette.
* Included the header with port IDs in patch 6 as suggested by Doug Anderson.
* Added patch 8 to revert the bandwidth configuration if any of the requests
  fails to apply. This came as a requirement for Nvidia platforms.

Changes since patchset v11 (https://lkml.org/lkml/2018/12/7/491)
* Squashed the newly introduced in v11 patch 8 into patch 5 to keep things
  bisectable. (Quentin Perret, Doug Anderson)
* Wrapped commit message of patch 2 to 75 chars.

Changes since patchset v10 (https://lkml.org/lkml/2018/11/28/2)
* Addressed comments from Joe Perches.
* Addressed comments from Evan Green and picked Reviewed-by.
* Changed the name of the DT node from qnoc to interconnect.
* Minor changes - typos, whitespaces etc.
* Added a new patch to adjust the sdm845 provider driver to the
  recently changed cmd_db API in linux-next.

Changes since patchset v9 (https://lkml.org/lkml/2018/8/31/444)
* Converted from using global node identifiers to local per provider ids.
* Dropped msm8916 platform driver until we figure out DT bindings.
* Included sdm845 platform driver instead.
* Added macros for converting to mbps, gbps, etc. to icc units.
* Added comments about aggregation, other minor changes.
* Fixed uninitialized variable. (Gustavo A. R. Silva)
* Removed set but not used variable. (YueHaibing)
* Fixed build error without DEBUGFS. (Arnd Bergmann)

Changes since patchset v8 (https://lkml.org/lkml/2018/8/10/387)
* Fixed the names of the files when built as modules.
* Corrected some typos in comments.

Changes since patchset v7 (https://lkml.org/lkml/2018/7/31/647)
* Addressed comments on kernel-doc and grammar. (Randy)
* Picked Reviewed-by: Evan
* Squashed consumer and provider DT bindings into single patch. (Rob)
* Cleaned-up msm8916 DT bindings docs by removing unused port ids.
* Updated documentation for the cases when NULL is returned. (Saravana)
* New patch to add myself as maintainer.

Changes since patchset v6 (https://lkml.org/lkml/2018/7/9/698)
* [patches 1,6]: Move the aggregation within the provider from the framework to
  the platform driver's set() callback, as the aggregation point could be SoC
  specific.
* [patch 1]: Include missing header, reset state only of the traversed nodes,
  move more code into path_init(), add more asserts, move misplaced mutex,
  simplify icc_link_destroy() (Evan)
* [patch 1]: Fix the order of requests to go from source to destination. (Alex)
* [patch 7]: Use better wording in the documentation. (Evan)
* [patch 6]: Reorder struct members, sort nodes alphabetically, improve naming
  of variables , add missing clk_disable_unprepare() in error paths. (Matthias)
* [patch 6]: Remove redundant NULL pointer check in msm8916 driver. (Alex)
* [patch 6]: Add missing depend on QCOM_SMD_RPM in Kconfig. (Evan)
* [patch 3]: Don't check for errors on debugfs calls, remove debugfs directory
  when module is unloaded (Greg)

Changes since patchset v5 (https://lkml.org/lkml/2018/6/20/453)
* Fix the modular build, make rpm-smd driver a module.
* Optimize locking and move to higher level. (Evan)
* Code cleanups. Fix typos. (Evan, Matthias)
* Add the source node to the path. (Evan)
* Rename path_allocate() to path_init() with minor refactoring. (Evan)
* Rename *_remove() functions to *_destroy().
* Return fixed errors in icc_link_destroy(). (Evan)
* Fix krealloc() usage in icc_link_destroy(). (Evan)
* Add missing kfree() in icc_node_create(). (Matthias)
* Make icc_node_add() return void. (Matthias)
* Change mutex_init to mutex_lock in icc_provider_add(). (Matthias)
* Add new icc_node_del() function to delete nodes from provider.
* Fix the header guard to reflect the path in smd-rpm.h. (Evan)
* Check for errors returned by qcom_icc_rpm_smd_send(). (Evan)
* Propagate the error of icc_provider_del(). (Evan)

Changes since patchset v4 (https://lkml.org/lkml/2018/3/9/856)
* Simplified locking by using a single global mutex. (Evan)
* Changed the aggregation function interface.
* Implemented functions for node, link, provider removal. (Evan)
* Naming changes on variables and functions, removed redundant code. (Evan)
* Fixes and clarifications in the docs. (Matthias, Evan, Amit, Alexandre)
* Removed mandatory reg DT property, made interconnect-names optional. (Bjorn)
* Made interconnect-cells property required to align with other bindings. (Neil)
* Moved msm8916 specific bindings into a separate file and patch. (Bjorn)
* Use the names, instead of the hardcoded ids for topology. (Matthias)
* Init the node before creating the links. (Evan)
* Added icc_units_to_bps macro. (Amit)

Changes since patchset v3 (https://lkml.org/lkml/2017/9/8/544)
* Refactored the constraints aggregation.
* Use the IDR API.
* Split the provider and consumer bindings into separate patches and propose
  new bindings for consumers, which allows to specify the local source port.
* Adopted the icc_ prefix for API functions.
* Introduced separate API functions for creating interconnect nodes and links.
* Added DT lookup support in addition to platform data.
* Dropped the event tracing patch for now.
* Added a patch to provide summary via debugfs.
* Use macro for the list of topology definitions in the platform driver.
* Various minor changes.

Changes since patchset v2 (https://lkml.org/lkml/2017/7/20/825)
* Split the aggregation into per node and per provider. Cache the
  aggregated values.
* Various small refactorings and cleanups in the framework.
* Added a patch introducing basic tracepoint support for monitoring
  the time required to update the interconnect nodes.

Changes since patchset v1 (https://lkml.org/lkml/2017/6/27/890)
* Updates in the documentation.
* Changes in request aggregation, locking.
* Dropped the aggregate() callback and use the default as it currently
  sufficient for the single vendor driver. Will add it later when needed.
* Dropped the dt-bindings draft patch for now.

Changes since RFC v2 (https://lkml.org/lkml/2017/6/12/316)
* Converted documentation to rst format.
* Fixed an incorrect call to mutex_lock. Renamed max_bw to peak_bw.

Changes since RFC v1 (https://lkml.org/lkml/2017/5/15/605)
* Refactored code into shorter functions.
* Added a new aggregate() API function.
* Rearranged some structs to reduce padding bytes.

Changes since RFC v0 (https://lkml.org/lkml/2017/3/1/599)
* Removed DT support and added optional Patch 3 with new bindings proposal.
* Converted the topology into internal driver data.
* Made the framework modular.
* interconnect_get() now takes (src and dst ports as arguments).
* Removed public declarations of some structs.
* Now passing prev/next nodes to the vendor driver.
* Properly remove requests on _put().
* Added refcounting.
* Updated documentation.
* Changed struct interconnect_path to use array instead of linked list.

David Dai (2):
  interconnect: qcom: Add sdm845 interconnect provider driver
  arm64: dts: sdm845: Add interconnect provider DT nodes

Georgi Djakov (6):
  interconnect: Add generic on-chip interconnect API
  dt-bindings: Introduce interconnect binding
  interconnect: Allow endpoints translation via DT
  interconnect: Add debugfs support
  MAINTAINERS: add a maintainer for the interconnect API
  interconnect: Revert to previous config if any request fails

 .../bindings/interconnect/interconnect.txt    |  60 ++
 .../bindings/interconnect/qcom,sdm845.txt     |  24 +
 Documentation/interconnect/interconnect.rst   |  94 ++
 MAINTAINERS                                   |  10 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   6 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/interconnect/Kconfig                  |  15 +
 drivers/interconnect/Makefile                 |   6 +
 drivers/interconnect/core.c                   | 799 +++++++++++++++++
 drivers/interconnect/qcom/Kconfig             |  13 +
 drivers/interconnect/qcom/Makefile            |   5 +
 drivers/interconnect/qcom/sdm845.c            | 838 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
 include/linux/interconnect-provider.h         | 142 +++
 include/linux/interconnect.h                  |  59 ++
 16 files changed, 2217 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/core.c
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/sdm845.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
