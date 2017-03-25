From: balbi@kernel.org (Felipe Balbi)
Date: Sat, 25 Mar 2017 09:53:17 +0200
Subject: [PATCH 2/7] usb: dwc3: dwc3-omap: fix dwc3_omap_probe() do
 put_sync when get_sync works
In-Reply-To: <a7d3539cdb21ef9694869f97a357ce40ace0ddd3.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
 <a7d3539cdb21ef9694869f97a357ce40ace0ddd3.1490387086.git.shuahkh@osg.samsung.com>
Message-ID: <87k27d23o2.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Shuah Khan <shuahkh@osg.samsung.com> writes:
> dwc3_omap_probe() does pm_runtime_put_sync() in its err1 handling when
> pm_runtime_get_sync() fails.  Fix it to do put_sync only when get_sync
> succeeds.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>

sorry, not taking any of these pointless patches. There's nothing wrong
with the goto labels, there's nothing wrong with the error path in any
of these drivers.

-- 
balbi
