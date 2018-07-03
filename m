From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 3 Jul 2018 12:27:25 +0300
Subject: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
In-Reply-To: <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180703092725.j7x2qxiwjgkejox2@um.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 04:33:28PM -0600, Mathieu Poirier wrote:
> It can be advantagous to have access to all the information conveyed by
> a perf_event when setting up the AUX buffer, as it is the case when
> dealing with PMU specific driver configuration communicated to the kernel
> using an ioctl() call.
> 
> As such simply replace the cpu information by the complete perf_event
> structure and change all affected customers.

Ok, but can you provide details about which parts of perf_event you need
and how they are used? Is it the attribute? What's the ioctl command in
question? Also, should we worry that the PMU specific configuration isn't
part of the attribute? Or, if not, why? I think we talked about this
before, but I forgot and this patch needs to explain it anyway.

Thanks!
--
Alex
